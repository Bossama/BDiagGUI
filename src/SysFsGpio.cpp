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

#include "SysFsGpio.h"
#include <stdio.h>
#include <QDebug>


SysFsGpio::SysFsGpio(int gpioNo, QObject *parent ) :
    QObject( parent ), m_gpioNo( gpioNo ), m_gpioValue( -1 )
{
}


SysFsGpio::~SysFsGpio()
{
    if (m_gpioFile.isOpen())
        m_gpioFile.close();
    QFile unexportFile;
    unexportFile.setFileName( "/sys/class/gpio/unexport" );
    if (!unexportFile.open(QIODevice::WriteOnly)) {
        qDebug() << "Could not open unexport for GPIO no. " << m_gpioNo;
        return;
    }
    qint64 bytesWritten = unexportFile.write( QString( "%1\n" ).arg(m_gpioNo).toLatin1() );
    if (bytesWritten < 0) {
        unexportFile.close();
        qDebug() << "Could not write to unexport file!";
    }
    unexportFile.close();
    qDebug() << "SysFsGpio::~SysFsGpio";
}


int SysFsGpio::init()
{
    int retVal = -1;

    // export the GPIO
    QFile exportFile;
    exportFile.setFileName( "/sys/class/gpio/export" );
    if (!exportFile.open(QIODevice::WriteOnly)) {
        qDebug() << "Could not open export for GPIO no. " << m_gpioNo;
        return -1;
    }
    qint64 bytesWritten = exportFile.write( QString( "%1\n" ).arg(m_gpioNo).toLatin1() );
    if (bytesWritten < 0) {
        exportFile.close();
        qDebug() << "Could not write to export file!";
        return -1;
    }
    exportFile.close();

    // Set the direction to input
    QFile dirFile;
    dirFile.setFileName( QString( "/sys/class/gpio/gpio%1/direction").arg(m_gpioNo) );
    if (!dirFile.open(QIODevice::WriteOnly)) {
        qDebug() << "Could not open direction file for GPIO no. " << m_gpioNo;
        return -1;
    }
    bytesWritten = dirFile.write( "in\n" );
    if (bytesWritten < 0) {
        dirFile.close();
        qDebug() << "Could not set direction for GPIO no. " << m_gpioNo;
        return -1;
    }
    dirFile.close();

    // Configure interrupt on rising and falling edge
    QFile edgeFile;
    edgeFile.setFileName( QString( "/sys/class/gpio/gpio%1/edge").arg(m_gpioNo) );
    if (!edgeFile.open(QIODevice::WriteOnly)) {
        qDebug() << "Could not open edge file for GPIO no. " << m_gpioNo;
        return -1;
    }
    bytesWritten = edgeFile.write( "both\n" );
    if (bytesWritten < 0) {
        edgeFile.close();
        qDebug() << "Could not set interrupt for GPIO no. " << m_gpioNo;
        return -1;
    }
    edgeFile.close();

    // Open the value file
    m_gpioFile.setFileName( QString( "/sys/class/gpio/gpio%1/value").arg(m_gpioNo ) );
    if (!m_gpioFile.open( QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Error opening gpio value file " << m_gpioFile.fileName();
    }

    // configure the notifier that allows interrupt based reading
    m_gpioNotifier = new QSocketNotifier(m_gpioFile.handle(), QSocketNotifier::Exception, this );
    m_gpioNotifier->setEnabled(true);
    connect(m_gpioNotifier, SIGNAL(activated(int)), this, SLOT(onGpioInt(int)));

    return retVal;
}


int SysFsGpio::getGpio()
{
    return m_gpioValue;
}


void SysFsGpio::onGpioInt(int socket )
{
    Q_UNUSED( socket ); // remove compiler warnings
    // interrupt occured. Read the data
    QByteArray rdData = m_gpioFile.read(16);
    m_gpioFile.seek(0); // reset filestream position to the beginning
    if (rdData[0] == '1') {
        m_gpioValue = 1;
    } else {
        m_gpioValue = 0;
    }
    emit gpioChanged( m_gpioValue );
}
