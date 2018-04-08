/*
 * Copyright (c) 2012 Romain Pokrzywka (KDAB) (romain@kdab.com)
 * Licensed under the MIT licence (http://opensource.org/licenses/mit-license.php)
 */

import QtQuick 2.9
import "CryptoApi.js" as Utils
Rectangle {
    width: 400
    height: 600

    Column {
        spacing: 5
        anchors.fill: parent
        anchors.margins: 5
        anchors.bottomMargin: 0

        ListView {
            id: list
            width: parent.width
            anchors.fill: parent


            JSONListModel {
                id: jsonModel
            }

            model: jsonModel.model

            delegate: Component {
                    Item {
                        width: parent.width
                        height: 40

                        Image {
                            anchors.left: parent
                            source: model.ImageUrl
                            width:  40
                            height:  40
                        }

                        Text {
                            anchors.right: parent
                            width: parent.width
                            horizontalAlignment: Text.AlignRight
                            font.pixelSize: 14
                            color: "black"
                            text: model.FullName
                        }
                    }
            }

            Component.onCompleted: {
                Utils.getAllExchangesList(function (response)
                {
                    var objectResponse = JSON.parse(response);
                    var data = objectResponse["Exmo"];
                    var coins = [];
                    for(var coin in data)
                        coins.push(coin);

                    Utils.getAllCoins(function (callbackResponse)
                    {
                        var callbackObjectResponse = JSON.parse(callbackResponse);
                        var baseUrl = callbackObjectResponse.BaseImageUrl;
                        var coinsObject = callbackObjectResponse.Data;
                        for (var index in coinsObject) {
                            if(coinsObject[index] !== undefined)
                                coinsObject[index].ImageUrl = baseUrl + coinsObject[index].ImageUrl;
                        }
                        /*
                        for (var index = 0; index < coins.length; ++index) {
                            coinsObject.push(callbackObjectResponse.Data[coins[index]]);
                            if(coinsObject[index] !== undefined)
                                coinsObject[index].ImageUrl = baseUrl + coinsObject[index].ImageUrl;
                        }
                        */
                        var stringData = JSON.stringify(coinsObject);
                        jsonModel.json = stringData;
                    });
                });
            }
        }
    }

    Component {
        id: sectionDelegate
        Rectangle {
            color: "gray"
            width: parent.width
            height: sectionLabel.height
            Text {
                id: sectionLabel
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.pixelSize: 16
                color: "white"
                style: Text.Raised
                text: section
            }
        }
    }
}
