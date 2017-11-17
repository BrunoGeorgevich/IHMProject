import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2

Drawer {
    height: 0.66 * root.height; width: parent.width
    edge: Qt.RightToLeft
    Column {
        anchors.fill: parent;
        spacing: height*0.05
        Item {
            width:parent.width
            height:parent.height*0.15
            TextField {
                id:searchTextField
                anchors.centerIn: parent
                width: parent.width*0.9
                height: parent.height*0.5
                color: Material.foreground
                placeholderText: "Search ..."
                onTextEdited: {
                    if(text == "")
                        grid.model = list
                    else {
                        changedList.clear()
                        for(var i = 0; i < list.count;i++)
                        {
                            if(list.get(i).name.toLowerCase().indexOf(text.toLowerCase()) !== -1) {
                                changedList.append(list.get(i));
                            }
                        }

                        grid.model = changedList
                    }
                }
            }
        }

        GridView {
            id:grid
            property int rows: 3
            property int cols: 3
            property real spacingH: width*0.05
            property real spacingV: height*0.05

            width:parent.width
            height:parent.height*0.8
            anchors { left:parent.left; leftMargin: spacingH/2}

            cellWidth: width/cols; cellHeight: height/rows;
            ListModel {
                id:changedList
            }
            ListModel {
                id:list
                ListElement {
                    name: "Circle"
                    icon: "qrc:/images/circle.png"
                }
                ListElement {
                    name: "Rectangle"
                    icon: "qrc:/images/rectangle.png"
                }
                ListElement {
                    name: "Square"
                    icon: "qrc:/images/square.png"
                }
                ListElement {
                    name: "Ellipse"
                    icon: "qrc:/images/ellipse.png"
                }
            }
            model: list
            delegate: Rectangle {
                id:gridButton
                width: grid.cellWidth - grid.spacingH
                height:grid.cellHeight - grid.spacingV
                color: Qt.lighter(Material.foreground); radius: parent.height*0.05
                Image {
                    id:buttonsGridIcon
                    source:icon
                    anchors {
                        top: parent.top; topMargin: parent.height*0.1
                        horizontalCenter: parent.horizontalCenter
                    }
                    sourceSize { height: parent.height*0.5; width: parent.width*0.5 }
                    fillMode: Image.PreserveAspectFit
                }
                ColorOverlay {
                    anchors.fill: buttonsGridIcon
                    source: buttonsGridIcon
                    color: colorDialog.color
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
                    onClicked: {
                        drawer.close()
                        switch(name) {
                        case "Circle":
                            canvas.setCircle = true
                            break
                        case "Rectangle":
                            canvas.setRectangle = true
                            break
                        case "Square":
                            canvas.setSquare = true
                            break
                        case "Ellipse":
                            canvas.setEllipse = true
                            break
                        }
                    }

                }
                Behavior on color {
                    ColorAnimation { duration: 200 }
                }
            }
        }
    }
}
