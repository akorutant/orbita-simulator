# -----------------------------------------------------------------------------
# -*- coding: utf-8 -*-
# -----------------------------------------------------------------------------
# The Orbita Simulator
# The Earth orbit simulation model (v2)
#
# The simulator missions implementation: The SMS Messaging System
#
# Copyright (C) 2015-2023 Alexey Fedoseev <aleksey@fedoseev.net>
# Copyright (C) 2016-2023 Ilya Tagunov <tagunil@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see https://www.gnu.org/licenses/
# -----------------------------------------------------------------------------

import time
import gettext

import data
import constants
from utils import generate_bytes
from mission import Mission
from logger import debug_log, mission_log

_ = gettext.gettext

class SmsMission(Mission):
    name = constants.MISSION_SMS

    def __init__(self, global_parameters):
        Mission.__init__(self, global_parameters)
        self.sms_messages = None

    def init(self, probe, initial_tick, lang):
        global _ # pylint: disable=W0603
        _ = lang

        radio = probe.systems[constants.SUBSYSTEM_RADIO]

        sms = {}
        for message in probe.xml.flight.mission.messages.message:
            sms[message.order] = [message.msgfrom,
                                  message.msgto,
                                  generate_bytes(int(message.data * 16)).encode('utf-8'),
                                  float(message.duration),
                                  None]

        self.sms_messages = []
        for order in sorted(sms.keys()):
            self.sms_messages.append(sms[order])
            debug_log(_('Message %d: %s->%s'),
                      order, sms[order][0], sms[order][1])

        if len(self.sms_messages) == 0:
            data.critical_error(probe,
                                _('The Probe definition did not contain any SMS message'))

        msgfrom, msgto, text, duration = self.sms_messages[0][0:4]
        radio.receive_data(msgfrom, len(text), (probe.mission, msgto, text, duration))

    def step(self, probe, tick):
        radio = probe.systems[constants.SUBSYSTEM_RADIO]

        for gs in radio.received_packets.keys():
            if len(radio.received_packets[gs]) != 0:
                for message in radio.received_packets[gs].values():
                    realdata = message[3]

                    if realdata[0] == self.name:
                        msg = _('SMS received form %s, time interval %f sec') % (realdata[1],
                                                                                 realdata[3])
                        debug_log(msg)
                        mission_log(msg)
                        self.sms_messages[0][4] = probe.time()

        for gs in radio.sent_packets.keys():
            if len(radio.sent_packets[gs]) != 0:
                for message in radio.sent_packets[gs].values():
                    realdata = message[3]

                    if realdata[0] == self.name:
                        source = realdata[1]
                        text = realdata[2]
                        msg = (_('Ground station %s received the SMS-message from %s size %d. ') %
                               (gs, source, len(text)))
                        error = False
                        errmsg = ''

                        if len(self.sms_messages) > 0:
                            sms = self.sms_messages[0]
                            if sms[0] != source:
                                errmsg += (_('Error: the message was received from the wrong source - %s instead of %s. ') % # pylint: disable=C0301
                                           (source, sms[0]))
                                error = True
                            if sms[1] != gs:
                                errmsg += (_('Error: the message was sent to the wrong destination - %s instead of %s. ') % # pylint: disable=C0301
                                           (gs, sms[1]))
                                error = True
                            if sms[2] != text:
                                errmsg += _('Error: the message was changed while transfered. ')
                                error = True
                            if sms[4] is not None:
                                dt = probe.time() - sms[4]
                                if sms[3] < dt:
                                    errmsg += (_('Error: the transfer time %f sec exceeded the valid interval %f sec.') % # pylint: disable=C0301
                                               (dt, sms[3]))
                                    error = True
                            else:
                                errmsg += _('Error: the probe tried to send message before receiving it. ') # pylint: disable=C0301
                                error = True
                        else:
                            errmsg += _('Error: all the messages were sent. ')
                            error = True

                        mission_log(msg + errmsg)
                        debug_log(msg + errmsg)

                        if error:
                            mission_log(_('Problems while sending SMS-message. ') + errmsg)
                        else:
                            mission_log(_('MISSION ACCOMPLISHED! SMS-message was transferred correctly.')) # pylint: disable=C0301
                            probe.success = True
                            if probe.message_number is None:
                                probe.message_number = 1
                            else:
                                probe.message_number += 1
                            probe.success_timestamp = time.time()

                        if len(self.sms_messages) > 0:
                            self.sms_messages.pop(0)

                        if len(self.sms_messages) > 0:
                            msgfrom, msgto, text, duration = self.sms_messages[0][0:4]
                            debug_log(_('New SMS-message %s->%s'), msgfrom, msgto)
                            radio.receive_queues_flush()
                            radio.receive_data(msgfrom, len(text),
                                               (constants.MISSION_SMS, msgto, text, duration))
                        else:
                            probe.completed = True


data.available_missions[SmsMission.name] = SmsMission
