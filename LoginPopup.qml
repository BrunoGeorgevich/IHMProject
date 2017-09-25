import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Dialog {
    id:loginPopupRoot
    width: parent.width*0.8; height: parent.height*0.8
    topMargin: (parent.height - height)/2;
    leftMargin: (parent.width - width)/2;

    Column {
        anchors.fill: parent

        Item {
            id:labelItem
            width: parent.width; height:parent.height*(0.15)
            Label {
                id:dialog
                anchors.centerIn: parent
                text:"Save diagrams to:"; color:Material.accent
                font.pixelSize: parent.height*0.3
            }
        }
        Item {
            id:lineItem
            width: parent.width; height: parent.height*0.01
            Rectangle {
                id:line
                color:Material.accent
                width: parent.width*0.9; height: parent.height*0.03
                anchors.horizontalCenter: parent.horizontalCenter

            }
        }
        Item {
            id:buttonsGridItem
            width: parent.width; height: parent.height*0.49
            GridView {
                id:buttonsGrid

                property int rows: 2
                property int cols: 3
                property real spacingH: loginPopupRoot.width*0.02
                property real spacingV: loginPopupRoot.height*0.02

                anchors { fill: parent; topMargin: buttonsGrid.spacingV; leftMargin: buttonsGrid.spacingH }
                cellHeight: buttonsGrid.height/rows; cellWidth: buttonsGrid.width/cols; interactive: false

                model: ListModel {
                    ListElement {
                        name: "Google Drive"
                        icon: "http://icons.iconarchive.com/icons/marcus-roberto/google-play/128/Google-Drive-icon.png"
                    }
                    ListElement {
                        name: "GitHub"
                        icon: "http://cdn4.iconfinder.com/data/icons/ionicons/512/icon-social-github-128.png"
                    }
                    ListElement {
                        name: "Dropbox"
                        icon: "http://icons.iconarchive.com/icons/xenatt/minimalism/128/App-dropbox-icon.png"
                    }
                    ListElement {
                        name: "OneDrive"
                        icon: "http://icons.iconarchive.com/icons/dakirby309/simply-styled/128/Microsoft-OneDrive-icon.png"
                    }
                    ListElement {
                        name: "Trello"
                        icon: "http://cdn2.iconfinder.com/data/icons/social-icons-33/128/Trello-128.png"
                    }
                    ListElement {
                        name: "Device"
                        icon: "http://cdn0.iconfinder.com/data/icons/typicons-2/24/cloud-storage-128.png"
                    }
                }
                delegate: Rectangle {
                    id:gridButton
                    height: (buttonsGrid.cellHeight - buttonsGrid.spacingV)
                    width: (buttonsGrid.cellWidth - buttonsGrid.spacingH)
                    color: Qt.lighter(Material.foreground); radius: parent.height*0.05
                    Image {
                        id:buttonsGridIcon
                        source:icon
                        anchors {
                            top: parent.top; topMargin: parent.height*0.1
                            horizontalCenter: parent.horizontalCenter
                        }
                        sourceSize { height: parent.height*0.6; width: parent.width*0.6 }
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id:gridButtonLabel
                        anchors{
                            top:buttonsGridIcon.bottom
                            horizontalCenter: buttonsGridIcon.horizontalCenter
                        }
                        text:name; color:Material.accent
                        font.pointSize: 12
                        Behavior on color {
                            ColorAnimation { duration: 100 }
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            gridButton.color = Qt.darker(Material.foreground)
                            gridButtonLabel.color = Qt.lighter(Material.accent)
                        }
                        onExited: {
                            gridButton.color = Qt.lighter(Material.foreground)
                            gridButtonLabel.color = Material.accent
                        }
                        onClicked: loginPopupRoot.close()

                    }
                    Behavior on color {
                        ColorAnimation { duration: 200 }
                    }
                }
            }
        }
        Item {
            id:bottomItem
            width: parent.width; height: parent.height*0.35
            Column {
                anchors.fill: parent
                spacing: parent.height*0.4
                Column {
                    width: parent.width; height: parent.height*0.4
                    spacing: parent.height*0.1
                    CheckBox {
                        text:"Remember this setting"
                        width: parent.width*0.5; height: parent.height*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    ComboBox {
                        model : ["Open Recent..."]
                        width: parent.width*0.5; height: parent.height*0.5
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Label {
                        text:"Import Gliffy, VSSX, VSDX, Lucidchart..."
                        height: parent.height*0.25
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
                Column {
                    width: parent.width; height: parent.height*0.5
                    Rectangle {
                        id:bottomLine
                        color: Material.accent
                        width: parent.width*0.95; height: parent.height*0.01
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Item {
                        id:bottomButtonsRow
                        width: parent.width*0.95; height: parent.height*0.01
                        anchors.horizontalCenter: parent.horizontalCenter
                        Button {
                            id:helpButton
                            height: root.height*0.06; width:parent.width*0.2
                            flat:true; hoverEnabled: false
                            anchors {
                                left:parent.left
                                verticalCenter: decideLaterButton.verticalCenter
                            }
                            Row{
                                anchors { fill:parent; margins: parent.height*0.2 }
                                Image {
                                    id:helpButtonImage
                                    source:"http://cdn2.iconfinder.com/data/icons/ios-7-icons/50/help-128.png"
                                    sourceSize.height: parent.height; mipmap: true
                                    fillMode: Image.PreserveAspectFit
                                }
                                Label {
                                    text:" Help"; color:Material.foreground
                                    anchors.verticalCenter: helpButtonImage.verticalCenter
                                    font.pointSize: 12
                                }
                            }
                        }
                        Button {
                            id:decideLaterButton
                            anchors.horizontalCenter: parent.horizontalCenter
                            text:"Decide Later"; flat:true
                            hoverEnabled: false
                        }
                        Button {
                            id:worldButton
                            height: root.height*0.05; width:height
                            flat:true; hoverEnabled: false
                            anchors {
                                right:parent.right
                                verticalCenter: decideLaterButton.verticalCenter
                            }
                            Image {
                                anchors { fill: parent; margins: parent.height*0.1}
                                source:"http://cdn3.iconfinder.com/data/icons/linecons-free-vector-icons-pack/32/world-128.png"
                                sourceSize.height: parent.height; mipmap: true
                                fillMode: Image.PreserveAspectFit
                            }
                        }
                    }
                }
            }
        }
    }
}
