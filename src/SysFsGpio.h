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

#ifndef SYSFSGPIO_H
#define SYSFSGPIO_H

#include <QObject>
#include <QFile>
#include <QSocketNotifier>


////////////////////////////////////////////////////////////////////////
/// \brief The SysFsGpio class allows control of GPIO's in the linux sys-fs
///
/// This class can be used for interrupt based reading GPI's that are available via sys-fs
/// It uses the virtual files that are avalable at '/sys/class/gpio'.
/// \note the Init memberfunction must be called before the gpio can be used!
class SysFsGpio : public QObject
{
    Q_OBJECT
public:
    explicit SysFsGpio( int gpioNo , QObject *parent = 0 );
    virtual ~SysFsGpio();

    ////////////////////////////////////////////////////////////////////
    /// \brief inititialize gpio. <b>Must be called before gpio can be used</b>
    /// \return 0 on success or -1 on error
    int init();


    ////////////////////////////////////////////////////////////////////
    /// \brief getGpio
    /// \return -1 on error, 0 if gpio-pin is low, 1 if gpio-pin is high
    int getGpio();

signals:
    ////////////////////////////////////////////////////////////////////
    /// \brief gpioChanged signal will be emitted when an interrupt has occured
    /// \param value  gpio value that was read (normally 0 or 1)
    void gpioChanged( int value );

public slots:
    void onGpioInt( int );

protected:
    int             m_gpioNo;
    QFile           m_gpioFile;
    QSocketNotifier *m_gpioNotifier;
    int             m_gpioValue;
};

#endif // SYSFSGPIO_H
