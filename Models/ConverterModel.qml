/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 2.9
import "./JSONListModel/CryptoApi.js" as Utils
ListModel {
    id: stocks
    property string firstCoin: "USD"
    property string secondCoin: "BTC"
    property var coinsList
    property ListModel model : ListModel {}
    property bool updating: false
    property var amountOfFirst
    property var amountOfSecond

    property var priceFirst
    property var priceSecond

    signal listLoaded
    signal computed

    function loadData(){
        Utils.getAllCoins(saveList);
    }

    function compute(first, second, source){
        amountOfFirst = first
        amountOfSecond = second

        switch(source){
        case "first":
            Utils.getCurrentPrice(firstCoin, secondCoin, updateSecond)
            break
        case "second":
            Utils.getCurrentPrice(firstCoin, secondCoin, updateFirst)
            break
        case "both":
            Utils.getCurrentPrice(firstCoin, secondCoin, updateFirst)
            Utils.getCurrentPrice(firstCoin, secondCoin, updateSecond)
            break
        }

    }

    function updateSecond(response){
        var callbackObjectResponse = JSON.parse(response);
        var price = callbackObjectResponse[secondCoin]
        priceSecond = amountOfFirst * price
        priceFirst = amountOfFirst
        computed()
    }

    function updateFirst(reponse) {
        var callbackObjectResponse = JSON.parse(response);
        var price = callbackObjectResponse[secondCoin]
        priceFirst = amountOfSecond / price
        priceSecond = amountOfSecond
        computed()
    }

    function saveList(response){
        stocks.clear();
        var callbackObjectResponse = JSON.parse(response);
        var coinsObject = callbackObjectResponse.Data;
        var coins = [];
        for (var index in coinsObject)
            coins.push(coinsObject[index]);
        coins.sort(compare);
        coins = coins.slice(0, 30);
        coinsList = []
        for (index in coins) {
            var rofl = coins[index]["Name"]
            coinsList.push(rofl)
        }
        listLoaded()
    }

    function acceptData(response){
        var callbackObjectResponse = JSON.parse(response);
        var baseUrl = callbackObjectResponse.BaseImageUrl;
        var coinsObject = callbackObjectResponse.Data;
        for (var index in coinsObject) {
            if(coinsObject[index] !== undefined)
                coinsObject[index].ImageUrl = baseUrl + coinsObject[index].ImageUrl;
        }

        //coinsObject.sort(compare);
        var coins = [];
        for (index in coinsObject)
            coins.push(coinsObject[index]);
        coins.sort(compare);
        coins = coins.slice(0, 30);
        coinsList = coins;
        var baseCoinsParam = transformCurrencyToParam(coins);
        Utils.getFromBaseToTargetFullInfo(baseCoinsParam, targetCoin, acceptConvertationData);
    }

    function acceptConvertationData(response){
        stocks.clear();
        var responseObject = JSON.parse(response);
        for (var index in coinsList){
            var coinName = coinsList[index].Name;
            coinsList[index].Dispay = responseObject.DISPLAY[coinName][targetCoin];
            coinsList[index].Raw = responseObject.RAW[coinName][targetCoin];
        }
        var coinz = coinsList;
        for (index in coinsList)
            stocks.append(coinsList[index]);
    }

    function compare(a, b) {
      var first = parseInt(a.SortOrder);
        var second = parseInt(b.SortOrder);
      if (first < second) {
        return -1;
      }

      if (first > second) {
        return 1;
      }

      return 0;
    }

    function transformCurrencyToParam(currencyObjects){
        var params = [];
        for (var index in currencyObjects)
            params.push(currencyObjects[index].Name);
        var requestParam = params.join(',');
        return requestParam;
    }
}

