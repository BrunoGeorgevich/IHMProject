import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2

RoundButton {
    property string overlayColor: Qt.lighter(Material.foreground)
    property string color: "#09A"
    property string sourcePath: ""
    Image {
        id:roundColorButtonIcon
        anchors {fill: parent; margins: parent.width*0.3 }
        source: parent.sourcePath
        fillMode: Image.PreserveAspectFit
        mipmap: true
    }
    ColorOverlay {
        anchors.fill: roundColorButtonIcon
        source: roundColorButtonIcon
        color: overlayColor
    }

    Component.onCompleted: background.color = color
}
