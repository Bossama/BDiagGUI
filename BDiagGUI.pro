TEMPLATE = app

QT += qml quick widgets dbus

SOURCES += main.cpp \
    src/FileIo.cpp \
    src/ProcessIf.cpp \
    src/SysFsLed.cpp \
    src/SysFsGpio.cpp \
    diagcontroller.cpp

RESOURCES += \
    images.qrc \
    controls.qrc \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/FileIo.h \
    src/ProcessIf.h \
    src/SysFsLed.h \
    src/SysFsGpio.h \
    diagcontroller.h

OTHER_FILES += \
    content/favorites.xml


DISTFILES += \
    fonts/fontawesome-webfont.ttf \
    fonts/icomoon.ttf \
    fonts/roboto-regular.ttf
