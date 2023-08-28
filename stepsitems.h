#ifndef STEPSACTIVITYITEM_H
#define STEPSACTIVITYITEM_H

#include <QObject>
#include <QVector>
#include "probe.h"
#include "devices.h"

struct DevicesItem;
struct ProbeItem;
class Probe;

struct StepsActivityAndLandingItem {
    int id;
    double time;
    QString device;
    QString command;
    QString argument;
};


class StepsActivityAndLanding : public QObject
{
    Q_OBJECT
public:
    explicit StepsActivityAndLanding(QObject *parent = nullptr);

    const QVector<StepsActivityAndLandingItem> activityItems() const;

    bool setActivityItem(int index, const StepsActivityAndLandingItem &item);

    const QVector<StepsActivityAndLandingItem> landingItems() const;
    bool setLandingItems(int index, const StepsActivityAndLandingItem &item);

signals:
    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int index);
    void postItemRemoved();

public slots:
    void appendItem(Probe* probe, bool typeCommand, int probeIndex, double time, QString device, QString command, QString argument);
    void removeItem(Probe* probe, bool typeCommand, int probeIndex, int index);

private:
    QVector<StepsActivityAndLandingItem> mActivityItems;
    QVector<StepsActivityAndLandingItem> mLandingItems;

};

#endif // STEPSACTIVITYITEM_H
