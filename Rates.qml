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
                height: 52
                color: "#000000"
                RowLayout {
                    spacing: 28
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 10
                    Text {
                        id: timeSpan
                        color: "#000000"
                        font.pointSize: 14
                        //font.weight: Font.Bold
                        verticalAlignment: Text.AlignVCenter
                        maximumLineCount: 1
                        text: "Time span:"
                        wrapMode: Text.Wrap
                        //anchors.margins: 10
                    }

                    Navibutton {
                        id: page1Button
                        text: "6 H"
                        stateSelect: "6 H"
                        stateTarget: targetorto
                        selected: true
                        Layout.minimumHeight:52
                        Layout.preferredHeight: 52
                        Layout.maximumHeight: 52
                    }

                    Navibutton {
                        id: page2Button
                        text: "1 D"
                        stateSelect: "1 D"
                        stateTarget: targetorto
                        Layout.minimumHeight:52
                        Layout.preferredHeight: 52
                        Layout.maximumHeight: 52
                    }

                    Navibutton {
                        id: page3Button
                        text: "7 D"
                        stateSelect: "7 D"
                        stateTarget: targetorto
                        Layout.minimumHeight:52
                        Layout.preferredHeight: 52
                        Layout.maximumHeight: 52
                    }

                    Navibutton {
                        id: page4Button
                        text: "30 D"
                        stateSelect: "30 D"
                        stateTarget: targetorto
                        Layout.minimumHeight:52
                        Layout.preferredHeight: 52
                        Layout.maximumHeight: 52
                    }

                    Navibutton {
                        id: page5Button
                        text: "6 M"
                        stateSelect: "6 M"
                        stateTarget: targetorto
                        Layout.minimumHeight:52
                        Layout.preferredHeight: 52
                        Layout.maximumHeight: 52
                    }

                    Navibutton {
                        id: page6Button
                        text: "1 Y"
                        stateTarget: targetorto
                        stateSelect: "1 Y"
                        Layout.minimumHeight:52
                        Layout.preferredHeight: 52
                        Layout.maximumHeight: 52
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

        onCoinNameChanged: {
            //exchages.update();
            stock.updateStock();
        }

        onTargetCoinNameChanged: {
            stock.updateStock();
        }

        onDataReady: {
            chart.updateStock(stock.stocks, stock.title);
            chart.update();
        }

        onTimeSpanChanged: {
            stock.updateStock();
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

