import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 600
    height: 800
    title: qsTr("Hello World")

    PrimaryPage {
        anchors.fill: parent
    }

    LoginPopup {
        visible: true
    }
}
