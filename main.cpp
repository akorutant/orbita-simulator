#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QLocale>
#include <QTranslator>

#include <QQmlContext>

#include "probe.h"
#include "devices.h"
#include "stepsitems.h"
#include "probemodel.h"
#include "stepsactivitymodel.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "Orbita-app_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }

    qmlRegisterType<ProbeModel>("ProbeModel", 1, 0, "ProbeModel");
    qmlRegisterType<DevicesModel>("DevicesModel", 1, 0, "DevicesModel");
    qmlRegisterType<StepsActivityModel>("StepsActivityModel", 1, 0, "StepsActivityModel");
    qmlRegisterUncreatableType<Probe>("Probe", 1, 0, "Probe",
                                        QStringLiteral("Probe should not be created in QML."));
    qmlRegisterUncreatableType<Devices>("Devices", 1, 0, "Devices",
                                        QStringLiteral("Devices should not be created in QML."));
    qmlRegisterUncreatableType<StepsActivityAndLanding>("StepsActivityAndLanding", 1, 0, "StepsActivityAndLanding",
                                        QStringLiteral("StepsActivityAndLanding should not be created in QML."));

    Probe probes;
    Devices modelDevices;
    StepsActivityAndLanding stepsActivityAndLanding;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty(QStringLiteral("probes"), &probes);
    engine.rootContext()->setContextProperty(QStringLiteral("modelDevices"), &modelDevices);
    engine.rootContext()->setContextProperty(QStringLiteral("stepsActivityAndLanding"), &stepsActivityAndLanding);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
