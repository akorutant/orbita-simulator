#include "simulationcontroller.h"

SimulationController::SimulationController(QObject *parent) : QObject(parent)
{
    simulationProcess = new QProcess(this);

    // Связываем сигнал finished() с обработчиком processFinished
    connect(simulationProcess, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(processFinished(int, QProcess::ExitStatus)));
}

void SimulationController::startSimulation(QString probePath)
{
    if (simulationProcess->state() != QProcess::NotRunning) {
        qDebug() << "Симуляция уже запущена или завершается.";
        return;
    }

    QString simulationPath = "simulations/models/planets/simulation.py";

    QStringList arguments;
    arguments << simulationPath << probePath
              << "--mission-log=telemetry.log"
              << "--image=.";

    qDebug() << "Запуск симуляции:";
    qDebug() << "Симулятор: " << simulationPath;
    qDebug() << "Аргументы: " << arguments.join(" ");

    simulationProcess->start("python3", arguments);
}

void SimulationController::stopSimulation()
{
    if (simulationProcess->state() == QProcess::Running) {
        simulationProcess->terminate();
        if (!simulationProcess->waitForFinished()) {
            qDebug() << "Ошибка при завершении симуляции: " << simulationProcess->errorString();
        }
    } else {
        qDebug() << "Симуляция не запущена.";
    }
}

void SimulationController::processFinished(int exitCode, QProcess::ExitStatus exitStatus)
{
    QByteArray standardOutput = simulationProcess->readAllStandardOutput();
    QByteArray standardError = simulationProcess->readAllStandardError();

    if (exitStatus == QProcess::NormalExit && exitCode == 0) {
        qDebug() << "Симуляция завершилась успешно.";
        if (!standardOutput.isEmpty()) {
            qDebug() << "Стандартный вывод симуляции:";
            qDebug() << standardOutput;
        }

    } else {
        qDebug() << "Ошибка при выполнении симуляции. Код завершения: " << exitCode;

        if (!standardOutput.isEmpty()) {
            qDebug() << "Стандартный вывод симуляции:";
            qDebug() << standardOutput;
        }

        if (!standardError.isEmpty()) {
            qDebug() << "Стандартная ошибка симуляции:";
            qDebug() << standardError;
        }
    }

    telemetryLogContents = readTelemetryLog();
    emit telemetryLogUpdated(telemetryLogContents);
}

QString SimulationController::readTelemetryLog()
{
    QString content;
    QFile file("./telemetry.log");

    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&file);
        content = in.readAll();
        file.close();
    }
    return content;
}

QString SimulationController::getTelemetryLogContents() const
{
    return telemetryLogContents;
}
