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

#ifndef PROCESSIF_H
#define PROCESSIF_H

#include <QObject>
#include <QString>
#include <QTimer>
#include <QtQml>
#include "SysFsLed.h"
#include "SysFsGpio.h"


////////////////////////////////////////////////////////////////////////////////////////////////
/// \brief The ProcessIf class is an example how to implement a interface to QML
/// The class is registered as a singleton in main.cpp
class ProcessIf : public QObject
{
    Q_OBJECT
public:

    static QObject *processif_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine);

    explicit ProcessIf(QObject *parent = 0);
    virtual ~ProcessIf();


    Q_PROPERTY(int led1 READ getLed1 WRITE setLed1 NOTIFY led1Changed)
    Q_PROPERTY(int led2 READ getLed2 WRITE setLed2 NOTIFY led2Changed)
    Q_PROPERTY(int led3 READ getLed3 WRITE setLed3 NOTIFY led3Changed)
    Q_PROPERTY(int gpio1 READ getGpio1 NOTIFY gpio1Changed) // read only property
    Q_PROPERTY(int gpio2 READ getGpio2 NOTIFY gpio2Changed) // read only property
    Q_PROPERTY(int gpio3 READ getGpio3 NOTIFY gpio3Changed) // read only property

    Q_PROPERTY(QString error READ getError NOTIFY errorChanged )  ///< allows passing error strings to Gui

    void   setLed1( int value );
    int    getLed1();
    void   setLed2( int value );
    int    getLed2();
    void   setLed3( int value );
    int    getLed3();

    int getGpio1();
    int getGpio2();
    int getGpio3();

    QString getError();

signals:
    void hasError( const QString& errorMessage );
    void led1Changed(int newVal);
    void led2Changed(int newVal);
    void led3Changed(int newVal);
    void gpio1Changed( int newVal );
    void gpio2Changed( int newVal );
    void gpio3Changed( int newVal );
    void errorChanged();

public slots:
    void timerTick();

private:
    int         m_led1Buff;
    int         m_led2Buff;
    int         m_led3Buff;
    QString     m_led1SysFsPath;
    QString     m_led2SysFsPath;
    QString     m_led3SysFsPath;
    SysFsLed*   p_led1;
    SysFsLed*   p_led2;
    SysFsLed*   p_led3;

    SysFsGpio*  p_gpio1;
    SysFsGpio*  p_gpio2;
    SysFsGpio*  p_gpio3;
    QString     m_errorString;

};

#endif // PROCESSIF_H
