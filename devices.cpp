#include "devices.h"

Devices::Devices(QObject *parent)
    : QObject{parent}
{

}

QVector<DevicesItem> Devices::items() const
{
    return mItems;
}

bool Devices::setDevicesItem(int index, const DevicesItem &item)
{
    if (index < 0 || index >= mItems.size())
        return false;

    const DevicesItem &olditem = mItems.at(index);
    if (item.deviceNumber == olditem.deviceNumber)
        return false;
    mItems[index] = item;
    return true;
}

void Devices::appendDevicesItem(Probe* probe, int probeIndex, QString deviceName, QString startState, bool inSafeMode)
{
    emit preDevicesItemAppended();

    mItems.append({mItems.size(), deviceName, startState, inSafeMode});
    probe->appendDevicesItem(probeIndex, deviceName, startState, inSafeMode);

    emit postDevicesItemAppended();

}

void Devices::removeDevicesItem(Probe* probe, StepsActivity* stepsActivity, StepsLanding* stepsLanding, int probeIndex, int index)
{
    emit preDevicesItemRemoved(index);

    QString deviceNameToRemove = mItems[index].deviceName;

    if (stepsActivity->items().size()) {
        for (int i = stepsActivity->items().size() - 1; i >= 0; --i)
        {
            if (stepsActivity->items()[i].device == deviceNameToRemove)
            {
                stepsActivity->removeItem(probe, false, probeIndex, i);
                break;
            }
        }
    }

    if (stepsLanding->items().size()) {
        for (int i = stepsLanding->items().size() - 1; i >= 0; --i)
        {
            if (stepsLanding->items()[i].device == deviceNameToRemove)
            {
                stepsLanding->removeItem(probe, true, probeIndex, i);
                break;
            }
        }
    }

    mItems.removeAt(index);
    probe->removeDevicesItem(probeIndex, index);

    emit postDevicesItemRemoved();
}


void Devices::changeDevices(Probe *probe, int probeIndex)
{

    for (int i = mItems.size() - 1; i >= 0; --i) {
        emit preDevicesItemRemoved(i);
        mItems.removeAt(i);
        emit postDevicesItemRemoved();
    }

    for (int i = 0; i < probe->items()[probeIndex].devices.size(); ++i) {
        emit preDevicesItemAppended();

        mItems.append({mItems.size(), probe->items()[probeIndex].devices[i].deviceName,
                       probe->items()[probeIndex].devices[i].startState,
                       probe->items()[probeIndex].devices[i].inSafeMode
                      });

        emit postDevicesItemAppended();
    }
}

int Devices::size()
{
    return mItems.size();
}
