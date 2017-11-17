import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2


Drawer {
    height: root.height; width: root.width*0.66
    edge: Qt.RightEdge

    Rectangle {
        anchors.fill: parent
        color: Material.foreground
    }

    ListView {
        id:chatListView

        anchors {
            fill: parent
            margins: parent.height*0.02
        }

        model: ListModel {
            id:chatModel
            ListElement {
                nick:"CGF"
                name:"Cristopher Gabriel Freitas"
                lastMessage:"O diagrama está ótimo"
                lastMessageTime:"12:23"
                basecolor:"Purple"
            }
            ListElement {
                nick:"ISA"
                name:"Isadora Cardoso"
                lastMessage:"Acho que o último item ficou estranho"
                lastMessageTime:"11:14"
                basecolor:"Red"
            }
        }

        spacing: height*0.02

        delegate: Rectangle {
            height: chatDrawer.height/6; width: parent.width*0.95
            radius: parent.width*0.04
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id:nickCircle
                anchors {
                    left: parent.left; top: parent.top
                    margins: parent.height*0.1
                }
                width: parent.width*0.15; height: width
                color: basecolor; radius: parent.width/2

                Label {
                    anchors.centerIn: parent
                    font { bold: false; pointSize: parent.height*0.2 }
                    color: "White"
                    text:nick
                }
            }

            Label {
                id:nameLabel
                anchors {
                    verticalCenter: nickCircle.verticalCenter
                    left: nickCircle.right
                    leftMargin: parent.width*0.05
                }
                font { bold: true; pointSize: parent.height*0.1 }
                text:name
            }

            Label {
                id:lastMessageLabel
                anchors {
                    left: nameLabel.left
                    verticalCenter: parent.verticalCenter
                }
                font { bold: false; pointSize: parent.height*0.08 }
                text:lastMessage
            }

            Item {
                width: parent.width*0.15; height: parent.height*0.12
                anchors {
                    right:parent.right; bottom: parent.bottom
                    margins: parent.height*0.1
                }
                Row {
                    anchors.fill: parent
                    spacing: parent.width*0.05

                    Image {
                        id: clockImage
                        height: parent.height; width: height
                        source: "qrc:/images/clock.png"
                        fillMode: Image.PreserveAspectFit
                        mipmap: true
                    }

                    Label {
                        text:lastMessageTime
                        font.pointSize: clockImage.height*0.60
                        anchors.verticalCenter: clockImage.verticalCenter
                    }
                }
            }
        }
    }


}
