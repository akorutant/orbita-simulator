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
    Q_PROPERTY(QString standardOutput READ getStandardOutput NOTIFY standardOutputUpdated)
    Q_PROPERTY(QString standardError READ getStandardError NOTIFY standardErrorUpdated)


public:
    explicit SimulationController(QObject *parent = nullptr);
    QString currentProbePath;
    QVector<ImageItem> imagesItems() const;
    bool setImages(int index, const ImageItem &item);

    QString getStandardOutput() const;
    QString getStandardError() const;

public slots:
    void startSimulation(QString probePath, SettingsManager *settingsManager);
    void stopSimulation();
    void processFinished(int exitCode, QProcess::ExitStatus exitStatus);

    QString readTelemetryLog();
    QString getTelemetryLogContents() const;
    void clearInfo();

    void loadImagesFromFolder(const QString &folderPath);
    void clearImages();


signals:
    void telemetryLogUpdated(const QString &contents);

    void imagesUpdated(const QVector<ImageItem> &contents);

    void standardOutputUpdated(const QString &output);
    void standardErrorUpdated(const QString &error);

    void preImageAppended();
    void postImageAppended();

    void preImageRemoved(int index);
    void postImageRemoved();

private:
    QProcess *simulationProcess;
    QString telemetryLogContents;
    QVector<ImageItem> images;

    QString mStandardOutput;
    QString mStandardError;

};

#endif // SIMULATORCONTROLLER_H
