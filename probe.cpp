#include "probe.h"

Probe::Probe(QObject *parent)
    : QObject{parent}
{
    mItems.append({1, "Apollo", 1200, 1500, "python", "file"});
    mDevicesItems.append({1, "test", "off", true});
}

QVector<ProbeItem> Probe::items() const
{
    return mItems;
}

bool Probe::setProbe(int index, const ProbeItem &item)
{
    if (index < 0 || index >= mItems.size())
        return false;

    const ProbeItem &olditem = mItems.at(index);
    if (item.probeNumber == olditem.probeName)
        return false;

    mItems[index] = item;
    return true;
}

void Probe::appendProbe(QString probeName, int outerRadius, int innerRadius, QString pythonCode, QString graphFile)
{
    emit preProbeAppended();

    ProbeItem item;
    mItems.append({mItems.size(), probeName, outerRadius, innerRadius, pythonCode, graphFile});

    emit postProbeAppended();
}

void Probe::removeProbe(int index)
{
    emit preProbeRemoved(index);

    mItems.removeAt(index);

    emit postProbeRemoved();
}

QVector<DevicesItem> Probe::devicesItems() const
{
    return mDevicesItems;
}

bool Probe::setDevicesItem(int index, const DevicesItem &item)
{
    if (index < 0 || index >= mDevicesItems.size())
        return false;

    const DevicesItem &olditem = mDevicesItems.at(index);
    if (item.deviceNumber == olditem.deviceNumber)
        return false;
    mDevicesItems[index] = item;
    return true;
}

void Probe::appendDevicesItem(QString deviceName, QString startState, bool inSafeMode)
{
    emit preDevicesItemAppended();

    DevicesItem item;

    mDevicesItems.append({mDevicesItems.size(), deviceName, startState, inSafeMode});

    emit postDevicesItemAppended();
}

void Probe::removeDevicesItem(int index)
{
    emit preDevicesItemRemoved(index);

    mDevicesItems.removeAt(index);

    emit postDevicesItemRemoved();
}


