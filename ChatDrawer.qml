import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2


Drawer {
    id:rootChatDrawer
    property var choosedChat: {}

    function back() {
        choosedChat: {}
        chatDrawerStackPages.pop()
    }

    height: root.height; width: root.width*0.66
    edge: Qt.RightEdge

    Rectangle {
        anchors.fill: parent
        color: Material.foreground
    }

    StackView {
        id:chatDrawerStackPages

        anchors.fill: parent
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }

        initialItem: Item {
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
                        messages: [
                            ListElement {
                                message:"Opa Cristopher, tudo bem?"
                                me:true
                            },
                            ListElement {
                                message:"Fala Bruno, tudo certo?"
                                me:false
                            },
                            ListElement {
                                message:"Tu gostou do diagrama?"
                                me:true
                            },
                            ListElement {
                                message:"O diagrama está ótimo"
                                me:false
                            }
                        ]

                    }
                    ListElement {
                        nick:"ISA"
                        name:"Isadora Cardoso"
                        lastMessage:"Acho que o último item ficou estranho"
                        lastMessageTime:"11:14"
                        basecolor:"Red"
                        messages: [
                            ListElement {
                                message:"Isadora, tudo bem?"
                                me:true
                            },
                            ListElement {
                                message:"Fala Bruno, tudo certo?"
                                me:false
                            },
                            ListElement {
                                message:"O que tu achou desse último item?"
                                me:true
                            },
                            ListElement {
                                message:"Acho que o último item ficou estranho"
                                me:false
                            }
                        ]
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
                            font { bold: false; pixelSize: parent.height*0.4 }
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
                        font { bold: true; pixelSize: parent.height*0.12 }
                        text:name
                    }

                    Label {
                        id:lastMessageLabel
                        anchors {
                            left: nameLabel.left
                            verticalCenter: parent.verticalCenter
                        }
                        font { bold: false; pixelSize: parent.height*0.1 }
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
                                font.pointSize: clockImage.height*0.40
                                anchors.verticalCenter: clockImage.verticalCenter
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            rootChatDrawer.choosedChat = chatModel.get(index)
                            chatDrawerStackPages.push(chatPageComponent)
                        }
                    }
                }
            }
        }
    }

    Component {
        id:chatPageComponent
        ChatPage {}
    }
}
