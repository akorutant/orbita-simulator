#ifndef PROBE_H
#define PROBE_H

#include <QObject>
#include <QVector>
#include "devices.h"

struct ProbeItem
{
    int probeNumber;
    QString probeName;
    int outerRadius;
    int innerRadius;
    QString pythonCode;
    QString graphFile;
};

class Probe : public QObject
{
    Q_OBJECT

public:
    explicit Probe(QObject *parent = nullptr);

    QVector<ProbeItem> items() const;

    bool setProbe(int index, const ProbeItem &item);


    QVector<DevicesItem> devicesItems() const;

    bool setDevicesItem(int index, const DevicesItem &item);

    const Devices &probeDevices() const;

signals:
   void preProbeAppended();
   void postProbeAppended();
   void preProbeRemoved(int index);
   void postProbeRemoved();

   void preDevicesItemAppended();
   void postDevicesItemAppended();
   void preDevicesItemRemoved(int index);
   void postDevicesItemRemoved();

public slots:
    void appendProbe(QString probeName, int outerRadius, int innerRadius, QString pythonCode, QString graphFile);
    void removeProbe(int index);

    void appendDevicesItem(QString deviceName, QString startState, bool inSafeMode);
    void removeDevicesItem(int index);

private:
    QVector<ProbeItem> mItems;
    QVector<DevicesItem> mDevicesItems;

};



#endif // PROBE_H
