#ifndef DEVICES_H
#define DEVICES_H

#include <QObject>
#include <QVector>

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

public slots:
    void appendDevicesItem();
    void removeDevicesItem(int index);

private:
    QVector<DevicesItem> mItems;
};

#endif // DEVICES_H
