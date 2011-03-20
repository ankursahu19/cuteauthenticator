import QtQuick 1.0
import "functions.js" as ExtFunc

Rectangle {
    width: 360
    height: 640
    id: mainWindow
    color: "black"
    signal newAccount(string name,string secretkey);
    Component.onCompleted: {

    }

    Component {
        id: accountDelegate

        Item {
            id: wrapper
            ListView.onRemove: SequentialAnimation {
                         PropertyAction { target: wrapper; property: "ListView.delayRemove"; value: true }
                         NumberAnimation { target: wrapper; property: "scale"; to: 0; duration: 250; easing.type: Easing.InOutQuad }
                         PropertyAction { target: wrapper; property: "ListView.delayRemove"; value: false }
                     }
            width: mainWindow.width; height: 90
            x: 20
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    itemCode.opacity -= 1/30
                    var newCode = ExtFunc.getcode(secretkey)
                    if (itemCode.text!=newCode) {
                        itemCode.text = newCode
                        codeRenewal.restart();
                        itemCode.opacity = 1
                    }
                }
            }

            Timer {
                id: codeRenewal
                  // Interval in milliseconds. It must be interval values.
                  interval: 30000
                 // Setting running to true indicates start the timer. It must be boolean  value.
                  running: true
                  //If repeat is set true, the timer will repeat at specified interval. Here it is 1000 milliseconds.
                  repeat: true
                  // This will be called when the timer is triggered. Here the
                  // subroutine changeBoxColor() will be called at every 1 seconde (1000 milliseconds)
                  onTriggered: {
                      itemCode.text = ExtFunc.getcode(secretkey)
                      itemCode.opacity = 1
                  }
              }
            Row {
                id: data
                spacing: 20
                Image {
                    y: 10
                    source: "qrc:/edit-clear.png"
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            parent.opacity = 0.5
                        }

                        onExited: {
                            parent.opacity = 1
                        }

                        onClicked: {
                            deleteAccountDialog.accountName = name
                            deleteAccountDialog.secretkey = secretkey
                            deleteAccountDialog.index = index
                            deleteAccountDialog.opacity = 0.9
                        }
                    }
                }

                Column {
                    Text {
                        text: name
                        color: "white"
                        font.pixelSize: 18
                    }
                    Text {
                        id: itemCode
                        text: ExtFunc.getcode(secretkey)
                        color: "white"
                        font.pixelSize: 40
                    }
                }
            }
            Rectangle {
                id: line
                anchors.top:  data.bottom
                height: 2
                width: mainWindow.width
                color: "#3060c8"
            }
        }
    }


    ListView {
        id: accounts
        anchors.top: information.bottom
        model: accountModel
        delegate: accountDelegate
        height: parent.height-header.height
        width: parent.width
        focus: true
        highlightRangeMode:  ListView.StrictlyEnforceRange
    }


    Rectangle {
        id: information
        anchors.top:  header.bottom
        color: "black"
        width: parent.width
        height: 100
        Text {
            id: information_text
            x: 60
            y: 20
            font.pixelSize: 16
            text: "Enter this verification code if\nprompted during account sign-in:"
            color: "white"
        }
    }

    Rectangle {
        id: header
        gradient: Gradient {
                  GradientStop { position: 0.0; color: "#3060c8" }
                  GradientStop { position: 1.0; color: "black"}
        }

        height: 20
        width: parent.width
        anchors.top: parent.top
    }

    Rectangle {
        id: footer
        gradient: Gradient {
                  GradientStop { position: 0.0; color: "#3060c8" }
                  GradientStop { position: 1.0; color: "black"}
        }

        height: 60
        width: parent.width
        anchors.bottom: parent.bottom

        Rectangle {
            anchors.right: parent.right
            anchors.top:  parent.top
            height: parent.height
            width: parent.width/2
            gradient: Gradient {
                      GradientStop { position: 0.0; color: "#3060c8" }
                      GradientStop { position: 1.0; color: "black"}
            }
            opacity: 1
            Image {
                source: "qrc:/application-exit.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity = 0.5
                }
                onExited: {
                    parent.opacity = 1
                }

                onClicked: {
                    Qt.quit()
                }
            }
        }

        Rectangle {

            height: parent.height
            width: parent.width/2
            anchors.left: parent.left
            anchors.top:  parent.top
            gradient: Gradient {
                      GradientStop { position: 0.0; color: "#3060c8" }
                      GradientStop { position: 1.0; color: "black"}
            }
            opacity: 1
            Image {
                source: "qrc:/bookmark-new.png"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity = 0.5
                }
                onExited: {
                    parent.opacity = 1
                }

                onClicked: {
                    addAccountDialogName.opacity = 0.9
                }
            }
        }
    }
    Dialog {
             id: deleteAccountDialog
             text: "Delete Account " + accountName
             property string accountName : ""
             property string secretkey : ""
             property int index : 0

             onConfirmed: {
                logic.removeAccount(index)
             }
    }
    InputDialog {
             id: addAccountDialogName
             text: "Account Name:"
             defaultText: accountName
             property string accountName : ""

             onConfirmed: {
                 if (input.length==0) return;
                 addAccountDialogSecretKey.accountName = input
                 addAccountDialogSecretKey.opacity = 0.9
             }
    }
    InputDialog {
             id: addAccountDialogSecretKey
             text: "Secret Key for\n " + accountName + ":"
             defaultText: accountSecretKey
             property string accountName : ""
             property string accountSecretKey : ""
             onConfirmed: {
                 if (input.length==0) return;
                 accountSecretKey = input
                 logic.addAccount(accountName,accountSecretKey)
             }
    }
}
