#include "probe.h"

Probe::Probe(QObject *parent)
    : QObject{parent}
{
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

void Probe::appendProbe(QString probeName, int outerRadius, int innerRadius, QString pythonCode)
{
    emit preProbeAppended();

    mItems.append({mItems.size(), probeName, outerRadius, innerRadius, {}, {},{},  pythonCode});

    emit postProbeAppended();
}

void Probe::removeProbe(int index)
{
    emit preProbeRemoved(index);

    mItems.removeAt(index);

    emit postProbeRemoved();
}

void Probe::appendDevicesItem(int probeIndex, QString deviceName, QString startState, bool inSafeMode)
{
    emit preDevicesItemAppended();

    mItems[probeIndex].devices.append({mItems[probeIndex].devices.size(), deviceName, startState, inSafeMode});

    emit postDevicesItemAppended();
}

void Probe::removeDevicesItem(int probeIndex, int index)
{
    emit preDevicesItemRemoved(index);

    mItems[probeIndex].devices.removeAt(index);

    emit postDevicesItemRemoved();
}

void Probe::appendActivityAndLandingItem(int probeIndex, bool typeCommand, double time, QString device, QString command, QString argument)
{
    emit preActivityAndLandingItemAppended();

    if (typeCommand)
        mItems[probeIndex].stepsLanding.append({mItems[probeIndex].stepsActivity.size(), time, device, command, argument});
    else
        mItems[probeIndex].stepsActivity.append({mItems[probeIndex].stepsActivity.size(), time, device, command, argument});

    emit postActivityAndLandingItemAppended();
}

void Probe::removeActivityAndLandingItem(int probeIndex, bool typeCommand, int index)
{
    emit preActivityAndLandingItemRemoved(index);

    if (typeCommand)
        mItems[probeIndex].stepsLanding.removeAt(index);
    else
        mItems[probeIndex].stepsActivity.removeAt(index);

    emit postActivityAndLandingItemRemoved();

}

void Probe::saveToXml(int probeIndex, const QString &filename)
{
    QFile file(filename);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        // Handle the error here
        return;
    }

    QXmlStreamWriter xmlWriter(&file);
    xmlWriter.setAutoFormatting(true);

    xmlWriter.writeStartDocument();
    xmlWriter.writeStartElement("v:probe");
    xmlWriter.writeAttribute("name", mItems[probeIndex].probeName);
    xmlWriter.writeNamespace("venus", "v");

    xmlWriter.writeStartElement("flight");

    xmlWriter.writeStartElement("mission");
    xmlWriter.writeAttribute("name", "Moon");
    xmlWriter.writeEndElement();

    xmlWriter.writeTextElement("start_height", "50000");

    xmlWriter.writeEndElement();


    xmlWriter.writeStartElement("parameters");
    xmlWriter.writeTextElement("radius_external", QString::number(mItems[probeIndex].outerRadius));
    xmlWriter.writeTextElement("radius_internal", QString::number(mItems[probeIndex].innerRadius));
    xmlWriter.writeTextElement("absorber", "OFF");
    xmlWriter.writeTextElement("isolator", "OFF");

    xmlWriter.writeEndElement();

    xmlWriter.writeStartElement("devices");

    for (const DevicesItem &deviceItem : mItems[probeIndex].devices)
    {
        xmlWriter.writeStartElement("device");
        xmlWriter.writeAttribute("number", QString::number(deviceItem.deviceNumber));
        xmlWriter.writeAttribute("name", QString(deviceItem.deviceName));
        xmlWriter.writeAttribute("start_state", QString(deviceItem.startState));
        if (deviceItem.inSafeMode) {
            xmlWriter.writeAttribute("in_safe_mode", "ON");
        } else {
            xmlWriter.writeAttribute("in_safe_mode", "OFF");
        }
        xmlWriter.writeEndElement();
    }

    xmlWriter.writeEndElement();


    xmlWriter.writeStartElement("program");

    xmlWriter.writeStartElement("stage");
    xmlWriter.writeAttribute("id", "Landing");
    for (const StepsLandingItem &stepsLanding : mItems[probeIndex].stepsLanding)
    {
        xmlWriter.writeStartElement("command");
        xmlWriter.writeAttribute("time", QString::number(stepsLanding.time));
        xmlWriter.writeAttribute("device", QString(stepsLanding.device));
        xmlWriter.writeAttribute("action", QString(stepsLanding.command));
        xmlWriter.writeAttribute("argument", QString(stepsLanding.argument));
        xmlWriter.writeEndElement();
    }
    xmlWriter.writeEndElement();

    xmlWriter.writeStartElement("stage");
    xmlWriter.writeAttribute("id", "Surface activity");

    for (const StepsActivityItem &stepsActivity : mItems[probeIndex].stepsActivity)
    {
        xmlWriter.writeStartElement("command");
        xmlWriter.writeAttribute("time", QString::number(stepsActivity.time));
        xmlWriter.writeAttribute("device", QString(stepsActivity.device));
        xmlWriter.writeAttribute("action", QString(stepsActivity.command));
        xmlWriter.writeAttribute("argument", QString(stepsActivity.argument));
        xmlWriter.writeEndElement();
    }
    xmlWriter.writeEndElement();

    // Write stages and commands here
    xmlWriter.writeEndElement(); // Close program

    // Close the root element
    xmlWriter.writeEndElement(); // Close v:probe
    xmlWriter.writeEndDocument();

    file.close();
}

void Probe::loadFromXml(const QString &filename) {
    QFile file(filename);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        // Обработка ошибки открытия файла
        return;
    }

    QXmlStreamReader xmlReader(&file);

    ProbeItem probeItem; // Создаем объект ProbeItem для загруженных данных

    while (!xmlReader.atEnd() && !xmlReader.hasError()) {
        xmlReader.readNext();

        if (xmlReader.isStartElement()) {
            QString elementName = xmlReader.name().toString();
            if (elementName == "v:probe") {
                // Пропустите начальный элемент <v:probe>
                continue;
            } else if (elementName == "mission") {
                // Обработка элемента <mission>
                QString missionName = xmlReader.attributes().value("name").toString();
                // Добавьте код для сохранения missionName в probeItem
            } else if (elementName == "start_height") {
                // Обработка элемента <start_height>
                QString startHeight = xmlReader.readElementText();
                // Добавьте код для сохранения startHeight в probeItem
            }
            // Обработайте другие элементы внутри <v:probe> аналогичным образом
        }
    }

    if (xmlReader.hasError()) {
        // Обработка ошибки чтения XML
        return;
    }

    // Если загрузка завершилась успешно, замените текущий объект Probe данными из probeItem
    mItems.append({1, "", 1, 1, {}, {}, {}, ""}); // Внести данные

    file.close();
}



void Probe::saveProbe(int probeIndex, QString probeName, int innerRadius, int outerRadius)
{
    mItems[probeIndex].probeName = probeName;
    mItems[probeIndex].outerRadius = outerRadius;
    mItems[probeIndex].innerRadius = innerRadius;
}

int Probe::size()
{
    return mItems.size();
}
