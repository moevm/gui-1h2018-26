import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 1200
    height: 600
    title: qsTr("Bitex")

    header: TabBar {
            id: tabBar
            TabButton {
                text: qsTr("Rates")
            }
            TabButton {
                text: qsTr("Converter")
            }
            TabButton {
                text: qsTr("News")
            }

            onCurrentIndexChanged: {
                switch (currentIndex)
                {
                case 0:
                    loader.source = "qrc:/Rates.qml"
                    //loader.source = "qrc:/Models/JSONListModel/example.qml"
                    break;
                case 1:
                    loader.source = "qrc:/Converter.qml"
                    break;
                case 2:
                    loader.source = "qrc:/News.qml"
                    break;
                }

            }
        }

        Loader {
            id: loader
            anchors.fill: parent
            source: "qrc:/Rates.qml"
        }
}
