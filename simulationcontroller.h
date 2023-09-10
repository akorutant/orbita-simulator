#ifndef SIMULATORCONTROLLER_H
#define SIMULATORCONTROLLER_H

#include <QObject>
#include <QProcess>
#include <QGuiApplication>
#include <QDebug>
#include <QFile>
#include <QTextStream>

class SimulationController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString telemetryLogContents READ getTelemetryLogContents NOTIFY telemetryLogUpdated)

public:
    explicit SimulationController(QObject *parent = nullptr);

public slots:
    void startSimulation(QString probePath);
    void stopSimulation();
    void processFinished(int exitCode, QProcess::ExitStatus exitStatus);

    QString readTelemetryLog();
    QString getTelemetryLogContents() const;

signals:
    void telemetryLogUpdated(const QString &contents);

private:
    QProcess *simulationProcess;
    QString telemetryLogContents;

};

#endif // SIMULATORCONTROLLER_H
