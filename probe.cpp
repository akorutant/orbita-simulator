#include "probe.h"

Probe::Probe(QObject *parent)
    : QObject{parent}
{
    mItems.append({1, "Apollo", 1200, 1500, "python", "file"});
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

void Probe::appendProbe()
{
    emit preProbeAppended();

    ProbeItem item;
    item.probeName = mItems.size();
    mItems.append(item);

    emit postProbeAppended();
}

void Probe::removeProbe(int index)
{
    emit preProbeRemoved(index);

    mItems.removeAt(index);

    emit postProbeRemoved();
}
