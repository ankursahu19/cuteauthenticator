/****************************************************************************
 **
 ** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
 ** All rights reserved.
 ** Contact: Nokia Corporation (qt-info@nokia.com)
 **
 ** This file is part of the examples of the Qt Mobility Components.
 **
 ** $QT_BEGIN_LICENSE:BSD$
 ** You may use this file under the terms of the BSD license as follows:
 **
 ** "Redistribution and use in source and binary forms, with or without
 ** modification, are permitted provided that the following conditions are
 ** met:
 **   * Redistributions of source code must retain the above copyright
 **     notice, this list of conditions and the following disclaimer.
 **   * Redistributions in binary form must reproduce the above copyright
 **     notice, this list of conditions and the following disclaimer in
 **     the documentation and/or other materials provided with the
 **     distribution.
 **   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
 **     the names of its contributors may be used to endorse or promote
 **     products derived from this software without specific prior written
 **     permission.
 **
 ** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 ** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 ** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 ** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 ** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 ** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 ** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 ** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 ** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 ** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 ** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 ** $QT_END_LICENSE$
 **
 ****************************************************************************/

 import Qt 4.7

 Rectangle {
     property string text: ""
     property string defaultText: ""
     property bool cancelable: true
     property int size: 0
     signal confirmed(string input);

     id: page
     opacity: 0

     width: parent.width;
     height: dialogText.height + okButton.height + inputText.height + 60
     anchors.verticalCenter: mainWindow.verticalCenter
     anchors.horizontalCenter: mainWindow.horizontalCenter

     border.width: 2
     color: Qt.lighter("#3060c8")

     Text {
         id: dialogText
         text: page.text
         font.pointSize: 16
         wrapMode: Text.Wrap
         x: 15; y: 15
         color: "black"
     }

     Rectangle {
         id: inputArea
         width: page.width - 30
         height: inputText.height + 4
         border.width: 1; color: "white"; radius: 1
         anchors.left: dialogText.left
         anchors.top: dialogText.bottom; anchors.topMargin: 7
     }

     TextInput {
         id: inputText
         text: page.defaultText
         font.pointSize: 10 * 2
         width: inputArea.width - 10
         anchors.verticalCenter: inputArea.verticalCenter
         anchors.horizontalCenter: inputArea.horizontalCenter
     }

     Button {
         id: okButton
         image: "qrc:/gtk-yes.png"
         width: 100
         height: 70
         anchors.top: inputArea.bottom; anchors.topMargin: 10

         onClicked: {
             page.confirmed(inputText.text);
             forceClose();
         }
     }

     Button {
         id: noButton
         image: "qrc:/gtk-no.png"
         width: 100
         height: 70
         anchors.left: page.horizontalCenter; anchors.leftMargin: 5
         anchors.top: inputArea.bottom; anchors.topMargin: 10

         onClicked: {
             forceClose();
         }
     }

     function forceClose()
     {
         page.opacity = 0;
         inputText.text = "";
     }

     Component.onCompleted: {
         if (cancelable == false) {
             noButton.opacity = 0;
             okButton.anchors.horizontalCenter = page.horizontalCenter;
         } else {
             okButton.anchors.right = page.horizontalCenter;
             okButton.anchors.rightMargin = 5;
         }

     }
 }
