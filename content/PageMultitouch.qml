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

import QtQuick 2.0

Rectangle {
    x: 4
    y: 4
    width: 680 - (2*x)
    height: 480 - (2*y)
    color: "black"
    opacity: 0.7
    radius: 5

//! [0]
    MultiPointTouchArea {
        anchors.fill: parent
        minimumTouchPoints: 1
        maximumTouchPoints: 5
        touchPoints: [
            TouchPoint { id: touch1 },
            TouchPoint { id: touch2 },
            TouchPoint { id: touch11 },
            TouchPoint { id: touch21 },
            TouchPoint { id: touch31 }
        ]
    }
//! [0]

//! [1]
    ParticleFlame {
        color: "red"
        emitterX: touch1.x
        emitterY: touch1.y
        emitting: touch1.pressed
    }
//! [1]
    ParticleFlame {
        color: "green"
        emitterX: touch2.x
        emitterY: touch2.y
        emitting: touch2.pressed
    }
    ParticleFlame {
        color: "yellow"
        emitterX: touch11.x
        emitterY: touch11.y
        emitting: touch11.pressed
    }
    ParticleFlame {
        color: "blue"
        emitterX: touch21.x
        emitterY: touch21.y
        emitting: touch21.pressed
    }
    ParticleFlame {
        color: "violet"
        emitterX: touch31.x
        emitterY: touch31.y
        emitting: touch31.pressed
    }
}
