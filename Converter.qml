import QtQuick 2.0
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "./Models"

Item {
    property alias text1: text1
    Rectangle {
        width: 360
        height: 200
        anchors.centerIn: parent


        GridLayout {
            id: gridLayout
            rows: 3
            columns: 2
            anchors.fill: parent
            Rectangle {
                Layout.columnSpan: 1
                Layout.rowSpan: 1
                height: selector.height
                Layout.fillWidth: true
                TextInput {
                    id: displayNumbers6Text
                    anchors.top: parent.top
                    width: parent.width
                    focus: true
                    validator: DoubleValidator { }
                    onTextChanged: {
                        if(converterModel.updating)
                            return
                        converterModel.compute(displayNumbers6Text.text, displayNumbers6Text1.text, "first")
                    }
                }
                Rectangle {
                    anchors.margins: 10
                    anchors.bottom: parent.bottom
                    height: 2
                    color: "#4ca8fc"
                    width: parent.width
                }
            }

            ComboBox {
                id: selector
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.margins: 10
                model: ["USD", "ETH", "RUB", "BTC", "EUR", "AUD", "BRL", "CAD", "CHF", "GBP",
                    "HKD"]
                onCurrentTextChanged: {
                    converterModel.firstCoin = selector.currentText;
                    converterModel.compute(displayNumbers6Text.text, displayNumbers6Text1.text, "both")
                }
            }

            Text {
                id: text1
                text: qsTr("=")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                Layout.columnSpan: 2
                font.pixelSize: 20
            }

            Rectangle {
                Layout.columnSpan: 1
                Layout.rowSpan: 1
                height: selector1.height
                Layout.fillWidth: true
                TextInput {
                    id: displayNumbers6Text1
                    anchors.top: parent.top
                    width: parent.width
                    validator: DoubleValidator { }
                    onTextChanged: {
                        if(converterModel.updating)
                            return
                        converterModel.compute(displayNumbers6Text.text, displayNumbers6Text1.text, "second")
                    }
                }
                Rectangle {
                    anchors.margins: 10
                    anchors.bottom: parent.bottom
                    height: 2
                    color: "#4ca8fc"
                    width: parent.width
                }
            }
            ComboBox {
                id: selector1
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.margins: 10
                model: ["USD", "ETH", "RUB", "BTC", "EUR", "AUD", "BRL", "CAD", "CHF", "GBP",
                    "HKD"]
                onCurrentTextChanged: {
                    converterModel.secondCoin = selector1.currentText;
                    converterModel.compute(displayNumbers6Text.text, displayNumbers6Text1.text, "both")
                }
            }
        }

        ConverterModel {
            id: converterModel
            onListLoaded: {
                selector.update()
                selector1.update()
            }

            onComputed: {
                updating = true
                displayNumbers6Text.text = priceFirst
                displayNumbers6Text1.text = priceSecond
                updating = false
            }
        }

        Component.onCompleted: {
            converterModel.loadData()
        }
    }
}

