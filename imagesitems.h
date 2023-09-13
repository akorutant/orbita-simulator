#ifndef IMAGESITEMS_H
#define IMAGESITEMS_H

#include <QObject>

class ImagesItems : public QObject
{
    Q_OBJECT
public:
    explicit ImagesItems(QObject *parent = nullptr);

signals:
private:
    QStringList mItems;

};

#endif // IMAGESITEMS_H
