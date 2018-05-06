import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import "./Models/JSONListModel"
import "./Views"
import "./Models"
import "./"
import "./content"
Item {
    id: root
    GridLayout {
        id: stockGrid
        columns: 2
        rows: 1
        columnSpacing: 0
        width: parent.width
        height: parent.height

        StockListView {
            id: stockListView
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.maximumWidth: 450
        }

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Rectangle {
                id: menuBar
                height: 100
                color: "#000000"

                ColumnLayout {
                    id: columnLayout
                    width: 100
                    height: 100
                    spacing: 7

                    RowLayout {
                        spacing: 28
                        Layout.margins: 5
                        property int buttonSize: 16
                        Text {
                            id: timeSpan
                            color: "#000000"
                            font.pointSize: 12
                            //font.weight: Font.Bold
                            verticalAlignment: Text.AlignVCenter
                            maximumLineCount: 1
                            text: "Time span:"
                            wrapMode: Text.Wrap
                        }

                        Navibutton {
                            id: page1Button
                            text: "6 H"
                            stateSelect: "6 H"
                            stateTarget: targetorto
                            selected: true
                            Layout.minimumHeight: parent.buttonSize
                            Layout.preferredHeight: parent.buttonSize
                            Layout.maximumHeight: parent.buttonSize
                        }

                        Navibutton {
                            id: page2Button
                            text: "1 D"
                            stateSelect: "1 D"
                            stateTarget: targetorto
                            Layout.minimumHeight:parent.buttonSize
                            Layout.preferredHeight: parent.buttonSize
                            Layout.maximumHeight: parent.buttonSize
                        }

                        Navibutton {
                            id: page3Button
                            text: "7 D"
                            stateSelect: "7 D"
                            stateTarget: targetorto
                            Layout.minimumHeight:parent.buttonSize
                            Layout.preferredHeight: parent.buttonSize
                            Layout.maximumHeight: parent.buttonSize
                        }

                        Navibutton {
                            id: page4Button
                            text: "30 D"
                            stateSelect: "30 D"
                            stateTarget: targetorto
                            Layout.minimumHeight:parent.buttonSize
                            Layout.preferredHeight: parent.buttonSize
                            Layout.maximumHeight: parent.buttonSize
                        }

                        Navibutton {
                            id: page5Button
                            text: "6 M"
                            stateSelect: "6 M"
                            stateTarget: targetorto
                            Layout.minimumHeight:parent.buttonSize
                            Layout.preferredHeight: parent.buttonSize
                            Layout.maximumHeight: parent.buttonSize
                        }

                        Navibutton {
                            id: page6Button
                            text: "1 Y"
                            stateTarget: targetorto
                            stateSelect: "1 Y"
                            Layout.minimumHeight:parent.buttonSize
                            Layout.preferredHeight: parent.buttonSize
                            Layout.maximumHeight: parent.buttonSize
                        }
                    }

                    RowLayout {
                        spacing: 10
                        Layout.margins: 5
                        property int buttonSize: 12
                        id: rofl
                        Text {
                            id: timeSpan1
                            color: "#000000"
                            text: "Average"
                            font.pointSize: 12
                            maximumLineCount: 1
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                        }

                        Switch {
                            id: averageSwitch
                            Layout.minimumHeight: parent.buttonSize
                            Layout.preferredHeight: parent.buttonSize
                            Layout.maximumHeight: parent.buttonSize
                        }

                        Text {
                            id: timeSpan2
                            color: "#000000"
                            text: "Moving Average"
                            font.pointSize: 12
                            maximumLineCount: 1
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                        }

                        Switch {
                            id: movingAverageSwitch
                            Layout.minimumHeight: parent.buttonSize
                            Layout.preferredHeight: parent.buttonSize
                            Layout.maximumHeight: parent.buttonSize
                        }

                        Text {
                            id: timeSpan3
                            color: "#000000"
                            text: "Candlestick"
                            font.pointSize: 12
                            maximumLineCount: 1
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                        }

                        Switch {
                            id: candlestickSwitch
                            Layout.minimumHeight: parent.buttonSize
                            Layout.preferredHeight: parent.buttonSize
                            Layout.maximumHeight: parent.buttonSize
                        }
                    }
                }
            }

            /*
            ExchangesView {
                id: exchages
                stockModel: stock
                Layout.fillHeight: true
                Layout.fillWidth: true
            } */

            StockChart {
                id: chart;
                Layout.fillHeight: true
                Layout.fillWidth: true

            }
        }
    }

    StockModel {
        id: stock
        coinName: stockListView.currentCoinName
        targetCoinName: stockListView.targetCoinName
        timeSpan: targetorto.state

        property bool average: averageSwitch.checked
        property bool movingAverage: movingAverageSwitch.checked
        property bool candlestick: candlestickSwitch.checked

        onAverageChanged: updateChart()
        onMovingAverageChanged: updateChart()
        onCandlestickChanged: updateChart()

        onCoinNameChanged: {
            //exchages.update();
            stock.updateStock();
        }

        onTargetCoinNameChanged: {
            stock.updateStock();
        }

        onDataReady: {
            updateChart()
        }

        onTimeSpanChanged: {
            stock.updateStock();
        }

        function updateChart(){
            chart.updateStock(stock.stocks, stock.title, average, movingAverage, candlestick);
            chart.update();
        }
    }

    Item {
        id: targetorto;

        state: "6 H"

        states: [
            State {
                name: "6 H"
            },
            //! [1]
            State {
                name: "1 D"
            },
            State {
                name: "7 D"
            },
            State {
                name: "30 D"
            },
            State {
                name: "6 M"
            },
            State {
                name: "1 Y"
            }
        ]

        onStateChanged: {
            updateButtons();
        }

        Component.onCompleted: {
            updateButtons();
        }

        function updateButtons(){
            page1Button.update();
            page2Button.update();
            page3Button.update();
            page4Button.update();
            page5Button.update();
            page6Button.update();
        }
    }

}

