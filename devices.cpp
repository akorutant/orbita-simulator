#include "devices.h"

Devices::Devices(QObject *parent)
    : QObject{parent}
{
    mItems.append({1, "test", "turnoff", true});
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

void Devices::removeDevicesItem(Probe* probe, int probeIndex, int index)
{
    emit preDevicesItemRemoved(index);

    mItems.removeAt(index);
    probe->removeDevicesItem(probeIndex, index);

    emit postDevicesItemRemoved();
}

bool Devices::changeDevices(Probe *probe, int probeIndex)
{
    emit preDevicesItemAppended();

    mItems.clear();
    mItems = probe->items()[probeIndex].devices;
    if (mItems.size())
        return true;

    return false;

    emit postDevicesItemAppended();
}
