#ifndef PROBE_H
#define PROBE_H

#include <QObject>
#include <QVector>

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


signals:
   void preProbeAppended();
   void postProbeAppended();

   void preProbeRemoved(int index);
   void postProbeRemoved();

public slots:
    void appendProbe();
    void removeProbe(int index);

private:
    QVector<ProbeItem> mItems;
};



#endif // PROBE_H
