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
    QVector<DevicesItem> devices;
    QString pythonCode;
};

class Probe : public QObject
{
    Q_OBJECT

public:
    explicit Probe(QObject *parent = nullptr);

    QVector<ProbeItem> items() const;

    bool setProbe(int index, const ProbeItem &item);

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
    void appendProbe(QString probeName, int outerRadius, int innerRadius, QString pythonCode );
    void removeProbe(int index);

    void appendDevicesItem(int probeIndex, QString deviceName, QString startState, bool inSafeMode);
    void removeDevicesItem(int probeIndex,int index);

private:
    QVector<ProbeItem> mItems;
};



#endif // PROBE_H
