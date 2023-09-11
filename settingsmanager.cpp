#include "settingsmanager.h"

SettingsManager::SettingsManager(QObject *parent) : QObject(parent)
{
    loadSettingsFromFile("planets_settings.txt");
}

QString SettingsManager::getProbesPath() const
{
    return probesPath;
}

QString SettingsManager::getSimulationPath() const
{
    return simulationPath;
}

QString SettingsManager::getDevicesPath() const
{
    return devicesPath;
}

QString SettingsManager::getPlanetsPath() const
{
    return planetsPath;
}

void SettingsManager::setProbesPath(const QString &path)
{
    probesPath = path;
}

void SettingsManager::setSimulationPath(const QString &path)
{
    simulationPath = path;
}

void SettingsManager::setDevicesPath(const QString &path)
{
    devicesPath = path;
}

void SettingsManager::setPlanetsPath(const QString &path)
{
    planetsPath = path;
}

bool SettingsManager::loadSettingsFromFile(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        return false;
    }

    QTextStream in(&file);
    while (!in.atEnd()) {
        QString line = in.readLine();
        if (line.startsWith("simulation_path=")) {
            simulationPath = line.mid(16);
        } else if (line.startsWith("probes_path=")) {
            probesPath = line.mid(12);
        } else if (line.startsWith("devices_path=")) {
            devicesPath = line.mid(13);
        } else if (line.startsWith("planets_path=")) {
            planetsPath = line.mid(13);
        }
    }

    file.close();
    return true;
}

bool SettingsManager::saveSettingsToFile(const QString &filePath)
{
    QFile file(filePath);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        return false;
    }

    QTextStream out(&file);
    out << "simulation_path=" << simulationPath << "\n";
    out << "probes_path=" << probesPath << "\n";
    out << "devices_path=" << devicesPath << "\n";
    out << "planets_path=" << planetsPath << "\n";

    file.close();
    return true;
}
