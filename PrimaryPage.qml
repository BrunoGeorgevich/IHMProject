import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2

Page {

    header: ToolBar {
        height: parent.height*0.07
        width: parent.width

        Row {
            anchors {
                fill:parent;
                topMargin: parent.height*0.02; bottomMargin: parent.height*0.02;
                leftMargin: parent.width*0.02; rightMargin: parent.width*0.02
            }
            spacing: parent.width*0.02
            Image {
                id: drawIOIcon
                height: parent.height; width: height
                fillMode: Image.PreserveAspectFit
                verticalAlignment: Image.AlignVCenter
                source: "qrc:/images/drawio.png"
            }
            Button {
                id:openButton
                height: parent.height
                text:"Open"; flat:true
                Component.onCompleted: openButton.contentItem.color = "White"
            }
            Button {
                id:saveButton
                height: parent.height
                text:"Save"; flat:true
                Component.onCompleted: saveButton.contentItem.color = "White"
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color:"White"
    }
    Image {
        id:milimeterBackground
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: "qrc:/images/milimeterPage.jpg"
    }

    Canvas {
        id:canvas
        anchors.fill: parent
        property var mainColor: colorDialog.color
        property bool setCircle    : false
        property bool setRectangle : false
        property bool setSquare    : false
        property bool setEllipse   : false
        function drawACircle(mouseX, mouseY) {
            var ctx = getContext("2d");
            ctx.beginPath();
            var side = 100
            ctx.fillStyle = mainColor
            ctx.ellipse(mouseX - side/2, mouseY - side/2, side, side);
            ctx.fill();
            ctx.closePath();
            requestPaint();
            setCircle = false
        }
        function drawAnEllipse(mouseX, mouseY) {
            var ctx = getContext("2d");
            ctx.beginPath();
            var side = 100
            ctx.fillStyle = mainColor
            ctx.ellipse(mouseX - side/2, mouseY - side/2, side*0.8, side);
            ctx.fill();
            ctx.closePath();
            requestPaint();
            setEllipse = false
        }
        function drawARect(mouseX, mouseY) {
            var ctx = getContext("2d");
            ctx.beginPath();
            var side = 100
            ctx.fillStyle = mainColor
            ctx.rect(mouseX - side/2, mouseY - side/2, side, side*0.6);
            ctx.fill();
            ctx.closePath();
            requestPaint();
            setRectangle = false
        }
        function drawASquare(mouseX, mouseY) {
            var ctx = getContext("2d");
            ctx.beginPath();
            var side = 100
            ctx.fillStyle = mainColor
            ctx.rect(mouseX - side/2, mouseY - side/2, side, side);
            ctx.fill();
            ctx.closePath();
            requestPaint();
            setSquare = false
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if(canvas.setRectangle)
                canvas.drawARect(mouseX, mouseY)
            else if(canvas.setCircle)
                canvas.drawACircle(mouseX, mouseY)
            else if(canvas.setEllipse)
                canvas.drawAnEllipse(mouseX, mouseY)
            else if(canvas.setSquare)
                canvas.drawASquare(mouseX, mouseY)
        }
    }

    RoundButton {
        width:parent.width*0.15; height: width
        anchors {
            bottom: parent.bottom; right: parent.right
            margins: parent.height*0.05
        }
        Image {
            id:roundButtonIcon
            anchors {fill: parent; margins: parent.width*0.3 }
            source: "http://cdn4.iconfinder.com/data/icons/mayssam/512/plus-128.png"
            fillMode: Image.PreserveAspectFit
            mipmap: true
        }
        ColorOverlay {
            anchors.fill: roundButtonIcon
            source: roundButtonIcon
            color: Qt.lighter(Material.foreground)
        }
        onClicked: drawer.open()

        Component.onCompleted: background.color = Material.accent
    }

    RoundButton {
        width:parent.width*0.15; height: width
        anchors {
            bottom: parent.bottom; left: parent.left
            margins: parent.height*0.05
        }
        Image {
            id:roundColorButtonIcon
            anchors {fill: parent; margins: parent.width*0.3 }
            source: "http://cdn3.iconfinder.com/data/icons/streamline-icon-set-free-pack/48/Streamline-35-128.png"
            fillMode: Image.PreserveAspectFit
            mipmap: true
        }
        ColorOverlay {
            anchors.fill: roundColorButtonIcon
            source: roundColorButtonIcon
            color: Qt.lighter(Material.foreground)
        }
        onClicked: colorDialog.open()

        Component.onCompleted: background.color = "#09A"
    }

    Drawer {
        id: drawer
        height: 0.66 * root.height; width: parent.width
        edge: Qt.BottomEdge
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

    ColorDialog {
        id:colorDialog
    }
}
