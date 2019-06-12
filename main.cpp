/*******************************************************************************
**
** MIT License
**
** Copyright (c) 2015 Werner Fries <werner.fries@fri-ware.de>
**
** Permission is hereby granted, free of charge, to any person obtaining a copy
** of this software and associated documentation files (the "Software"), to deal
** in the Software without restriction, including without limitation the rights
** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the Software is
** furnished to do so, subject to the following conditions:
**
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
** THE SOFTWARE.
**
****************************************************************************/

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QFont>
#include <QFontDatabase>
#include "src/ProcessIf.h"
#include "src/FileIo.h"
#include <QDebug>



void WriteDefaultSettings()
{
    QSettings settings;
    QString group = settings.group();
    qDebug( group.toLatin1() );
    settings.setValue("led1", "/sys/devices/user_leds.8/leds/user_led_green/brightness" );
    settings.setValue("led2", "/sys/devices/user_leds.8/leds/user_led_yellow/brightness" );
    settings.setValue("led3", "/sys/devices/user_leds.8/leds/user_led_red/brightness" );
    settings.setValue("gpio1No", 20 );
    settings.setValue("gpio2No", 7 );
    settings.setValue("gpio3No", 106 );

}


int main(int argc, char *argv[])
{
    // Load virtualkeyboard input context plugin
     qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);
    app.setFont(QFont("Bitstream Vera Sans"));

    // Font Load from the phyRDK-1.4-PD18
    int id = QFontDatabase::addApplicationFont(":/fonts/roboto-regular.ttf");
    if (id == -1) {
        qDebug("Cannot open font roboto-regular");
    } else {
        QString family = QFontDatabase::applicationFontFamilies(id).at(0);
        QFont roboto(family);
        app.setFont(roboto);
    }
    id = QFontDatabase::addApplicationFont(":/fonts/icomoon.ttf");
    if (id == -1)
        qDebug("Cannot open font icomoon");
    id = QFontDatabase::addApplicationFont(":/fonts/fontawesome-webfont.ttf");
    if (id == -1)
        qDebug("Cannot open font fontawesome");


    // Write organisation- and application name.
    // Will be used by QSettings to define the location of the settings-file
    app.setOrganizationName( "Phytec" );
    app.setApplicationName( "PhyKitDemo" );
    QSettings settings;
    QFile file(settings.fileName());
    if( !file.exists() )
    {
        qDebug( "WARNING: Settings file %s not found!\n", settings.fileName().toLatin1().data() );
        qDebug( "Writing new settings file with default values.\n" );
        WriteDefaultSettings();
    }

    // Register FileIO, to make it visible to Qml
    qmlRegisterType<FileIO>("FriWare.FileIO", 1, 0, "FileIO");

    // Register ProcessIf as singleton. It is used to talk to the hardware.
    // The hardware exists only once, therefore it makes sense to instatiate it as a singleton,
    // to avoid conflicts when accessed from different locations in the source code.
    qmlRegisterSingletonType<ProcessIf>("FriWare.ProcessIf", 1, 0, "ProcessIf", ProcessIf::processif_singletontype_provider );

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
