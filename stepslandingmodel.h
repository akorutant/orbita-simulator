#ifndef STEPSLANDINGMODEL_H
#define STEPSLANDINGMODEL_H

#include <QAbstractListModel>
#include "stepsitems.h"

class StepsActivityAndLanding;

class StepsLandingModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit StepsLandingModel(QObject *parent = nullptr);

    enum {
        idRole = Qt::UserRole,
        timeRole,
        deviceRole,
        commandRole,
        argumentRole
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

    StepsActivityAndLanding *list() const;
    void setList(StepsActivityAndLanding *list);

private:
    StepsActivityAndLanding *mList;
};

#endif // STEPSLANDINGMODEL_H
