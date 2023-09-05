#ifndef PROBE_H
#define PROBE_H

#include <QObject>
#include <QVector>
#include <QFile>
#include <QXmlStreamWriter>
#include "devices.h"
#include "stepsactivity.h"
#include "stepslanding.h"

struct DevicesItem;
struct StepsActivityItem;
struct StepsLandingItem;

struct ProbeItem
{
    int probeNumber;
    QString probeName;
    int outerRadius;
    int innerRadius;
    QVector<DevicesItem> devices;
    QVector<StepsActivityItem> stepsActivity;
    QVector<StepsLandingItem> stepsLanding;
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

   void preActivityAndLandingItemAppended();
   void postActivityAndLandingItemAppended();
   void preActivityAndLandingItemRemoved(int index);
   void postActivityAndLandingItemRemoved();

public slots:
    void appendProbe(QString probeName, int outerRadius, int innerRadius, QString pythonCode);
    void removeProbe(int index);

    void appendDevicesItem(int probeIndex, QString deviceName, QString startState, bool inSafeMode);
    void removeDevicesItem(int probeIndex,int index);

    void appendActivityAndLandingItem(int probeIndex, bool typCommand, double time, QString device, QString command, QString argument);
    void removeActivityAndLandingItem(int probeIndex, bool typeCommand, int index);

    void saveToXml(int probeIndex, const QString &filename);

    int size();

private:
    QVector<ProbeItem> mItems;
};



#endif // PROBE_H
