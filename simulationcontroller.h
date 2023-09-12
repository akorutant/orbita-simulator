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

class SimulationController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString telemetryLogContents READ getTelemetryLogContents NOTIFY telemetryLogUpdated)

public:
    explicit SimulationController(QObject *parent = nullptr);
    QString currentProbePath;

public slots:
    void startSimulation(QString probePath, SettingsManager *settingsManager);
    void stopSimulation();
    void processFinished(int exitCode, QProcess::ExitStatus exitStatus);

    QString readTelemetryLog();
    QString getTelemetryLogContents() const;
    QStringList loadImagesFromFolder(const QString &folderPath);
    QStringList getImages();

signals:
    void telemetryLogUpdated(const QString &contents);

private:
    QProcess *simulationProcess;
    QString telemetryLogContents;
    QStringList images;

};

#endif // SIMULATORCONTROLLER_H
