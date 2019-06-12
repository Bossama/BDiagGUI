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

#include "ProcessIf.h"
#include <QTimer>


// called by QmlEngine to create singleton Object
QObject* ProcessIf::processif_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    ProcessIf *processIf = new ProcessIf();
    return processIf;
}


ProcessIf::ProcessIf(QObject *parent) :
    QObject(parent)
{
    QSettings settings;
    m_led1SysFsPath = settings.value( "led1" ).toString();
    m_led2SysFsPath = settings.value( "led2" ).toString();
    m_led3SysFsPath = settings.value( "led3" ).toString();

    p_led1 = new SysFsLed( m_led1SysFsPath.toLatin1() );
    p_led2 = new SysFsLed( m_led2SysFsPath.toLatin1() );
    p_led3 = new SysFsLed( m_led3SysFsPath.toLatin1() );

    m_errorString = "Test error";
    emit errorChanged();

    m_led1Buff = getLed1();
    m_led2Buff = getLed2();
    m_led3Buff = getLed3();

    int gpio1No = settings.value( "gpio1No" ).toInt();
    p_gpio1 = new SysFsGpio( gpio1No );
    int ret = p_gpio1->init();
    if (ret < 0) {
        m_errorString = QString( "ERROR: could not initialize GPIO %1" ).arg( gpio1No );
        qDebug() << m_errorString;
        emit errorChanged();
    }

    int gpio2No = settings.value( "gpio2No" ).toInt();
    p_gpio2 = new SysFsGpio( gpio2No );
    ret = p_gpio2->init();
    if (ret < 0) {
        m_errorString = QString( "ERROR: could not initialize GPIO %1" ).arg( gpio2No );
        qDebug() << m_errorString;
        emit errorChanged();
    }

    int gpio3No = settings.value( "gpio3No" ).toInt();
    p_gpio3 = new SysFsGpio( gpio3No );
    ret = p_gpio3->init();
    if (ret < 0) {
        m_errorString = QString( "ERROR: could not initialize GPIO %1" ).arg( gpio3No );
        qDebug() << m_errorString;
        emit errorChanged();
    }

    // directly connect signals, so they will be forewarded to the GUI
    connect( p_gpio1, SIGNAL(gpioChanged(int)), this, SIGNAL(gpio1Changed(int)) );
    connect( p_gpio2, SIGNAL(gpioChanged(int)), this, SIGNAL(gpio2Changed(int)) );
    connect( p_gpio3, SIGNAL(gpioChanged(int)), this, SIGNAL(gpio3Changed(int)) );


    QTimer* timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(timerTick()));
    timer->start(250);
}


ProcessIf::~ProcessIf()
{
    qDebug( "ProcessIf::~ProcessIf() called\n" );
    delete p_led1;
    delete p_led2;
    delete p_led3;
    delete p_gpio1;
    delete p_gpio2;
    delete p_gpio3;
}


void ProcessIf::setLed1( int value )
{
    p_led1->setLed( value );
}

void ProcessIf::setLed2( int value )
{
    p_led2->setLed( value );
}

void ProcessIf::setLed3( int value )
{
    p_led3->setLed( value );
}



int ProcessIf::getLed1()
{
    int ret = p_led1->getLed();

    if (ret != m_led1Buff) {
        m_led1Buff = ret;
        emit led1Changed(m_led1Buff);
    }

    return m_led1Buff;
}


int ProcessIf::getLed2()
{
    int ret = p_led2->getLed();

    if (ret != m_led2Buff) {
        m_led2Buff = ret;
        emit led2Changed(m_led2Buff);
    }

    return m_led2Buff;
}


int ProcessIf::getLed3()
{
    int ret = p_led3->getLed();

    if (ret != m_led3Buff) {
        m_led3Buff = ret;
        emit led3Changed(m_led3Buff);
    }

    return m_led3Buff;
}


int ProcessIf::getGpio1()
{
    return  p_gpio1->getGpio();
}


int ProcessIf::getGpio2()
{
    return p_gpio2->getGpio();
}


int ProcessIf::getGpio3()
{
    return p_gpio3->getGpio();
}


QString ProcessIf::getError()
{
    return m_errorString;
}

void ProcessIf::timerTick()
{
    // linux user LED's do not support interupts, so they must be polled
    getLed1();
    getLed2();
    getLed3();
}
