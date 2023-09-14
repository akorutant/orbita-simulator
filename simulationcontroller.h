#ifndef SIMULATORCONTROLLER_H
#define SIMULATORCONTROLLER_H

#include <QObject>
#include <QProcess>
#include <QGuiApplication>
#include <QDebug>
#include <QFile>
#include <QTextStream>
#include <QDir>
#include <QFileInfoList>

#include "settingsmanager.h"

class SettingsManager;

struct ImageItem {
    QString imageSource;
};

class SimulationController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString telemetryLogContents READ getTelemetryLogContents NOTIFY telemetryLogUpdated)

public:
    explicit SimulationController(QObject *parent = nullptr);
    QString currentProbePath;
    QVector<ImageItem> imagesItems() const;
    bool setImages(int index, const ImageItem &item);

public slots:
    void startSimulation(QString probePath, SettingsManager *settingsManager);
    void stopSimulation();
    void processFinished(int exitCode, QProcess::ExitStatus exitStatus);

    QString readTelemetryLog();
    QString getTelemetryLogContents() const;
    void loadImagesFromFolder(const QString &folderPath);

signals:
    void telemetryLogUpdated(const QString &contents);
    void imagesUpdated(const QVector<ImageItem> &contents);

    void preImageAppended();
    void postImageAppended();

    void preImageRemoved(int index);
    void postImageRemoved();

private:
    QProcess *simulationProcess;
    QString telemetryLogContents;
    QVector<ImageItem> images;

};

#endif // SIMULATORCONTROLLER_H
