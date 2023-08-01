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

void Devices::appendDevicesItem()
{
    emit preDevicesItemAppended();

    DevicesItem item;
    item.deviceNumber = mItems.size();
    mItems.append(item);

    emit postDevicesItemAppended();
}

void Devices::removeDevicesItem(int index)
{
    emit preDevicesItemRemoved(index);

    mItems.removeAt(index);

    emit postDevicesItemRemoved();
}
