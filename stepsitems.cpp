#include "stepsitems.h"

StepsActivityAndLanding::StepsActivityAndLanding(QObject *parent)
    : QObject{parent}
{

}

const QVector<StepsActivityAndLandingItem> StepsActivityAndLanding::activityItems() const
{
    return mActivityItems;
}


bool StepsActivityAndLanding::setActivityItem(int index, const StepsActivityAndLandingItem &item)
{
    if (index < 0 || index >= mActivityItems.size())
        return false;

    const StepsActivityAndLandingItem &olditem = mActivityItems.at(index);
    if (item.id == olditem.id)
        return false;
    mActivityItems[index] = item;
    return true;
}

void StepsActivityAndLanding::appendItem(Probe* probe, bool typeCommand, int probeIndex, double time,
                                         QString device, QString command, QString argument)
{
    emit preItemAppended();
    if (typeCommand)
        mActivityItems.append({mActivityItems.size(), time, device, command, argument});
    else
        mLandingItems.append({mLandingItems.size(), time, device, command, argument});
    \

    probe->appendActivityAndLandingItem(probeIndex, typeCommand, time, device, command, argument);

    emit postItemAppended();
}

void StepsActivityAndLanding::removeItem(Probe* probe, bool typeCommand, int probeIndex, int index)
{
    emit preItemRemoved(index);

    if (typeCommand)
        mActivityItems.removeAt(index);
    else
        mLandingItems.removeAt(index);

    probe->removeActivityAndLandingItem(probeIndex, typeCommand, index);

    emit postItemRemoved();
}

const QVector<StepsActivityAndLandingItem> StepsActivityAndLanding::landingItems() const
{
    return mLandingItems;
}

bool StepsActivityAndLanding::setLandingItems(int index, const StepsActivityAndLandingItem &item)
{
    if (index < 0 || index >= mLandingItems.size())
        return false;

    const StepsActivityAndLandingItem &olditem = mLandingItems.at(index);
    if (item.id == olditem.id)
        return false;
    mLandingItems[index] = item;
    return true;
}
