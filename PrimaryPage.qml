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
        RoundImageButton {
            height: parent.height; width: height
            anchors.right: parent.right
            color: "White"
            sourcePath: "qrc:/images/chat.png"
            overlayColor: Material.primary
            onClicked: chatDrawer.open()
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

    RoundImageButton {
        color: Material.accent
        sourcePath:  "http://cdn4.iconfinder.com/data/icons/mayssam/512/plus-128.png"
        width:parent.width*0.15; height: width
        anchors {
            bottom: parent.bottom; right: parent.right
            margins: parent.height*0.05
        }
        onClicked: drawer.open()

        Component.onCompleted: background.color = Material.accent
    }

    RoundImageButton {
        color: "#09A"
        sourcePath: "http://cdn3.iconfinder.com/data/icons/streamline-icon-set-free-pack/48/Streamline-35-128.png"
        width:parent.width*0.15; height: width
        anchors {
            bottom: parent.bottom; left: parent.left
            margins: parent.height*0.05
        }
        onClicked: colorDialog.open()
    }

    ChatDrawer { id:chatDrawer }

    ItemDrawer { id: drawer }

    ColorDialog {
        id:colorDialog
    }
}
