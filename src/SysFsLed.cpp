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

#include "SysFsLed.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

SysFsLed::SysFsLed( const char* sysFsFile )
{
    m_sysFsFile = new char[strlen(sysFsFile)];
    strcpy( m_sysFsFile, sysFsFile );
}


SysFsLed::~SysFsLed()
{
    delete[] m_sysFsFile;
}


int SysFsLed::setLed( int value )
{
    FILE * pFile;
    int retVal = -1;

    if( value > 255 )
    {
        fprintf(stderr, "%s: Warning: value out of range! (%i)", __FUNCTION__, value );
        value = 255;
    }
    if( value < 0 )
    {
        fprintf(stderr, "%s: Warning: value out of range! (%i)", __FUNCTION__, value );
        value = 0;
    }

    pFile = fopen( m_sysFsFile , "r+" );
    if (pFile == NULL)
    {
        perror ("Error opening file");
    }
    else
    {
        char buffer[16];
        snprintf(buffer, sizeof(buffer), "%i\n",value);
        size_t bytesWritten = fwrite( buffer, 1, sizeof(buffer), pFile );
        if( bytesWritten > 0 )
        {
            retVal = 0;
        }
        else
        {
            perror( "Error writing to file" );
        }
        fclose (pFile);
    }
    return retVal;
}


int SysFsLed::getLed()
{
    FILE * pFile;
    int retVal = -1;
    char buffer [32];

    pFile = fopen( m_sysFsFile , "r" );
    if (pFile == NULL)
    {
        perror ("Error opening file");
    }
    else
    {
        size_t bytesRead = fread( buffer, 1, sizeof(buffer), pFile );
        if( bytesRead > 0 )
        {
            int val = atoi( buffer );
            retVal = val;
        }
        else
        {
            perror( "Error reading from file" );
        }
        fclose (pFile);
    }
    return retVal;
}
