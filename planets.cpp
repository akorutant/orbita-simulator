#include "planets.h"

Planets::Planets(QObject *parent)
    : QObject{parent}
{
    QFile file("./simulations/models/planets/planets.xml");
    if (!file.open(QFile::ReadOnly | QFile::Text)) {
        qDebug() << "Не удалось открыть файл";
        return;
    }

    QXmlStreamReader xmlReader(&file);

    while (!xmlReader.atEnd() && !xmlReader.hasError()) {
        QXmlStreamReader::TokenType token = xmlReader.readNext();
        if (token == QXmlStreamReader::StartElement) {
            if (xmlReader.name() == "planet") {
                PlanetsItem planet;
                planet.id = mItems.size();
                planet.planetName = xmlReader.attributes().value("name").toString();
                while (!(xmlReader.tokenType() == QXmlStreamReader::EndElement && xmlReader.name() == "planet")) {
                    xmlReader.readNext();
                    if (xmlReader.name() == "height") {
                        planet.height = xmlReader.readElementText().toDouble();
                    }
                }

                mItems.append(planet);
            }
        }
    }


    file.close();
}

QVector<PlanetsItem> Planets::items() const
{
    return mItems;
}

bool Planets::setPlanets(int index, const PlanetsItem &item)
{
    if (index < 0 || index >= mItems.size())
        return false;

    const PlanetsItem &olditem = mItems.at(index);
    if (item.id == olditem.id)
        return false;

    mItems[index] = item;
    return true;
}

