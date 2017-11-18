import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Page {
    id:chatPageRoot
    header: ToolBar {
        width: parent.width; height: parent.height*0.07
        RoundImageButton  {
            height: parent.height; width: height
            sourcePath: "qrc:/images/back.png"
            color: "White" ; overlayColor: Material.primary
            onClicked: {
                rootChatDrawer.back()
            }
        }

        Label {
            anchors.centerIn: parent
            font { bold: true; pixelSize: parent.height*0.33 }
            text: rootChatDrawer.choosedChat.name; color: "White"
        }
    }

    Item {
        id:messagesListViewItems
        anchors.fill: parent

        ListView {
            id:messagesListView
            anchors {
                fill: parent
                margins: parent.height*0.05
            }

            model: rootChatDrawer.choosedChat.messages
            spacing: parent.height*0.1

            delegate: Rectangle {
                height: rootChatDrawer.height*0.1; width: parent.width*0.66
                color: me ? "#09A" : "#0B6"; radius: parent.width*0.1

                Label {
                    anchors {
                        fill: parent
                        margins: parent.height*0.2
                        verticalCenter: parent.verticalCenter
                    }
                    font.pixelSize: parent.height*0.3; color: "White"
                    fontSizeMode: "Fit"
                    text:message; wrapMode: "WrapAtWordBoundaryOrAnywhere"

                }

                Component.onCompleted: {
                    if(me)
                        anchors.right = parent.right
                    else
                        anchors.left = parent.left
                }
            }
        }
    }

    footer: Item {
        height: parent.height*0.1; width: parent.width

        Row {
            anchors {
                fill: parent
                margins: parent.height*0.2
            }
            spacing: parent.width*0.05

            TextField {
                id:messageTextField
                width: parent.width*0.8; height: parent.height
                font.pixelSize: height*0.4
            }
            RoundImageButton {
                height: parent.height; width: height;
                sourcePath: "qrc:/images/send.png"
                onClicked: {
                    rootChatDrawer
                    .choosedChat
                    .messages.append({
                                         message:messageTextField.text,
                                         me:true
                                     })
                    messageTextField.text = ""

                }
            }
        }
    }
}
