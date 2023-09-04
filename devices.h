#ifndef DEVICES_H
#define DEVICES_H

#include <QObject>
#include <QVector>
#include "probe.h"

class Probe;

struct DevicesItem
{
    int deviceNumber;
    QString deviceName;
    QString startState;
    bool inSafeMode;
};

class Devices : public QObject
{
    Q_OBJECT
public:
    explicit Devices(QObject *parent = nullptr);

    QVector<DevicesItem> items() const;

    bool setDevicesItem(int index, const DevicesItem &item);

signals:
    void preDevicesItemAppended();
    void postDevicesItemAppended();

    void preDevicesItemRemoved(int index);
    void postDevicesItemRemoved();

    void preDevicesItemCleared();
    void postDevicesItemCleared();

public slots:
    void appendDevicesItem(Probe* probe, int probeIndex, QString deviceName, QString startState, bool inSafeMode);
    void removeDevicesItem(Probe* probe, int probeIndex, int index);

    void changeDevices(Probe* probe, int probeIndex);

    int size();

private:
    QVector<DevicesItem> mItems;
};

#endif // DEVICES_H
