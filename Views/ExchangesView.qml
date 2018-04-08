import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls 1.4
import "../Models/JSONListModel/CryptoApi.js" as Utils

Item {
    //width: parent.width
   //height: parent.height

    TableView {
        width: parent.width
        height: parent.height

        TableViewColumn {
            role: "open"
            title: "Open"
            width: 100
        }
        TableViewColumn {
            role: "close"
            title: "Close"
            width: 100
        }
        TableViewColumn {
            role: "high"
            title: "High"
            width: 100
        }
        TableViewColumn {
            role: "low"
            title: "Low"
            width: 100
        }

        TableViewColumn {
            role: "timestamp"
            title: "Date"
            width: 200
        }
        model: libraryModel
    }

    ListModel {
        id: libraryModel
        property var name : null
        property string target: null

        function update(coinName, targetCoin){
            name = coinName;
            target = targetCoin;
            libraryModel.clear();
            loadData();
        }

        function loadData(){
            Utils.getCoinInfoByHours(name, target, 24, acceptCustomAverage)
        }

        function acceptCustomAverage(response){
            var dataObject = JSON.parse(response).Data;
            for(var index in dataObject){
                dataObject[index].timestamp = new Date(dataObject[index].time*1000).toDateString();
                libraryModel.append(dataObject[index]);
            }
        }
    }

    property var stockModel: null

    function update(){
        var coinName = stockModel.coinName;
        var targetCoin = stockModel.targetCoinName;
        var stok = stockModel;
        libraryModel.update(coinName, targetCoin);
    }
}
