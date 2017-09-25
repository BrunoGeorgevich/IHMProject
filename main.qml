import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    id: root
    visible: true
    width: 600
    height: 800
    title: qsTr("Hello World")

    LoginPopup {
        visible: true
    }

//    Drawer {
//        id:drawer
//        dragMargin: root.width*0.1; dim:false; edge: Qt.BottomEdge
//        width: root.width; height: root.height*0.5
//        onXChanged: {
//            mainPage.y = drawer.height+drawer.y
//            mainPage.height = root.height - mainPage.y
//        }
//    }

//    Page {
//        id:mainPage
//        height:root.height; width: root.width

//        SwipeView {
//            id: swipeView
//            anchors.fill: parent
//            currentIndex: tabBar.currentIndex

//            Page {
//                Label {
//                    text: qsTr("Favoritos")
//                    anchors.centerIn: parent
//                }
//            }
//            Page {
//                Label {
//                    text: qsTr("Adicionar")
//                    anchors.centerIn: parent
//                }
//            }
//            Page {
//                Label {
//                    text: qsTr("Meu Perfil")
//                    anchors.centerIn: parent
//                }
//            }
//        }

//        header: TabBar {
//            id: tabBar
//            currentIndex: swipeView.currentIndex
//            TabButton {
//                text: qsTr("Favoritos")
//            }
//            TabButton {
//                text: qsTr("Adicionar")
//            }
//            TabButton {
//                text: qsTr("Meu Perfil")
//            }
//        }
//    }
}
