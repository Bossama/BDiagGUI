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

import QtQuick 2.3
//import Qt.labs.folderlistmodel 2.1

Rectangle {
    id: root
    width: 800
    height: 480
    color: "black"

      // Delegate for the recipes.  This delegate has two modes:
      // 1. List mode (default), which just shows the picture and title of the recipe.
      // 2. Details mode, which also shows the ingredients and method.
      Component {
          id: recipeDelegate
  //! [0]
          Item {
              id: recipe

              // Create a property to contain the visibility of the details.
              // We can bind multiple element's opacity to this one property,
              // rather than having a "PropertyChanges" line for each element we
              // want to fade.
              property real detailsOpacity : 0
  //! [0]
              width: listView.width
              height: 70

              // A simple rounded rectangle for the background
              Rectangle {
                  id: background
                  x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
                  color: "ivory"
                  border.color: "orange"
                  radius: 5
              }

              // This mouse region covers the entire delegate.
              // When clicked it changes mode to 'Details'.  If we are already
              // in Details mode, then no change will happen.
  //! [1]
              MouseArea {
                  anchors.fill: parent
                  onClicked: recipe.state = 'Details';
              }

              // Lay out the page: picture, title and ingredients at the top, and method at the
              // bottom.  Note that elements that should not be visible in the list
              // mode have their opacity set to recipe.detailsOpacity.

              Row {
                  id: topLayout
                  x: 10; y: 10; height: recipeImage.height; width: parent.width
                  spacing: 10

                  Image {
                      id: recipeImage
                      width: 50; height: 50
                      source: picture
                  }
  //! [1]
                  Column {
                      width: background.width - recipeImage.width - 20; height: recipeImage.height
                      spacing: 5

                      Text {
                          text: title
                          font.bold: true; font.pointSize: 16
                      }

//                      Text {
//                          text: "Ingredients"
//                          font.bold: true
//                          opacity: recipe.detailsOpacity
//                          font.pixelSize: 12
//                      }

                      Text {
                          text: ingredients
                          wrapMode: Text.WordWrap
                          width: parent.width
                          opacity: recipe.detailsOpacity
                          font.pixelSize: 12
                      }
                  }
              }

  //! [2]
              Item {
                  id: details
                  x: 10; width: parent.width - 20

                  anchors { top: topLayout.bottom; topMargin: 10; bottom: parent.bottom; bottomMargin: 10 }
                  opacity: recipe.detailsOpacity
  //! [3]
              }

              // A button to close the detailed view, i.e. set the state back to default ('').
              TextButton {
                  y: 10
                  anchors { right: background.right; rightMargin: 10 }
                  opacity: recipe.detailsOpacity
                  text: "Close"

                  onClicked: recipe.state = '';
              }

              states: State {
                  name: "Details"

                  PropertyChanges { target: background; color: "white" }
                  PropertyChanges { target: recipeImage; width: 130; height: 130 } // Make picture bigger
                  PropertyChanges { target: recipe; detailsOpacity: 1; x: 0 } // Make details visible
                  PropertyChanges { target: recipe; height: listView.height } // Fill the entire list area with the detailed view

                  // Move the list so that this item is at the top.
                  PropertyChanges { target: recipe.ListView.view; explicit: true; contentY: recipe.y }

                  // Disallow flicking while we're in detailed view
                  PropertyChanges { target: recipe.ListView.view; interactive: false }
              }

              transitions: Transition {
                  // Make the state changes smooth
                  ParallelAnimation {
                      ColorAnimation { property: "color"; duration: 500 }
                      NumberAnimation { duration: 300; properties: "detailsOpacity,x,contentY,height,width" }
                  }
              }
          }
          //! [3]
              }

              // The actual list
              ListView {
                  id: listView
                  anchors.fill: parent
                  model: RecipesModel {}
                  delegate: recipeDelegate
              }
          }

