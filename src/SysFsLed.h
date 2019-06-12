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

#ifndef SYSFSLED_H
#define SYSFSLED_H


/////////////////////////////////////////////////////////////////////
/// \brief The SysFsLed class allows Qt-independent access to user LED's
///
/// \note This class is not reentrant or threadsave!
///
class SysFsLed
{
public:
    SysFsLed( const char* sysFsFile );
    ~SysFsLed();

    ////////////////////////////////////////////////////////////////
    /// \brief setLed
    /// \param value brightness value. Must be between 0 and 255
    /// \return -1 on error or 0 on success
    int setLed( int value );

    ////////////////////////////////////////////////////////////////
    /// \brief getLed
    /// \return the current value of the led read from sysfs
    int getLed();

private:
    char* m_sysFsFile;
};

#endif // SYSFSLED_H
