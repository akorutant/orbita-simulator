QT += quick

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        devices.cpp \
        devicesmodel.cpp \
        main.cpp \
        probe.cpp \
        probemodel.cpp \
        stepsactivitymodel.cpp \
        stepsitems.cpp \
        stepslandingmodel.cpp

RESOURCES += qml.qrc

TRANSLATIONS += \
    Orbita-app_ru_RU.ts
CONFIG += lrelease
CONFIG += embed_translations

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    devices.h \
    devicesmodel.h \
    probe.h \
    probemodel.h \
    stepsactivitymodel.h \
    stepsitems.h \
    stepslandingmodel.h
