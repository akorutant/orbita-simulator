#include "planetdevices.h"

PlanetDevices::PlanetDevices(QObject *parent)
    : QObject{parent}
{
    QFile file("./simulations/models/planets/devices-ru.xml");
    if (!file.open(QFile::ReadOnly | QFile::Text))
    {
        return;
    }

    QXmlStreamReader xmlReader(&file);

    while (!xmlReader.atEnd() && !xmlReader.hasError())
    {
        QXmlStreamReader::TokenType token = xmlReader.readNext();

        if (token == QXmlStreamReader::StartElement && xmlReader.name() == "device")
        {
            PlanetDeviceItems device;
            device.id = mItems.size();
            device.deviceEngName = xmlReader.attributes().value("name").toString();
            device.deviceName = xmlReader.attributes().value("full_name").toString();
            device.deviceCode = xmlReader.attributes().value("code").toString();
            mItems.append(device);
        }
    }

    if (xmlReader.hasError())
        return;

    file.close();
}

QVector<PlanetDeviceItems> PlanetDevices::items() const
{
    return mItems;
}

bool PlanetDevices::setPlanetDevices(int index, const PlanetDeviceItems &item)
{
    if (index < 0 || index >= mItems.size())
        return false;

    const PlanetDeviceItems &olditem = mItems.at(index);
    if (item.id == olditem.id)
        return false;

    mItems[index] = item;
    return true;
}

QString PlanetDevices::getDeviceCode(QString deviceName)
{
    for (int i = 0; i < mItems.size(); ++i) {
        if (mItems[i].deviceName == deviceName)
            return mItems[i].deviceCode;
    }
    return "None";
}

QString PlanetDevices::getDeviceEngName(QString deviceName)
{
    for (int i = 0; i < mItems.size(); ++i) {
        if (mItems[i].deviceName == deviceName)
            return mItems[i].deviceEngName;
    }
    return "None";
}
