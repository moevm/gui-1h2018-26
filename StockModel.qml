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

import QtQuick 2.0
import "./Models/JSONListModel/CryptoApi.js" as Utils

ListModel {
    id: model
    property string coinName: ""
    property string stockName: ""
    property string targetCoinName: ""
    property string timeSpan: ""
    property string title: ""
    property var stocks: []
    signal dataReady

    function indexOf(date) {

    }

    function createStockPrice(r) {

    }

    function createStock(response) {
        var rofl = JSON.parse(response);
        if(rofl["Response"] == "Error")
            return;
        model.title = "Rates from " + model.coinName + " to " + model.targetCoinName + " for " + model.timeSpan;
        //stocks.length = 0;
        stocks = rofl["Data"];
        model.dataReady();
    }

    function updateStock() {
        switch(model.timeSpan){
            case "6 H":
                Utils.getCoinInfoByHours(model.coinName, model.targetCoinName, 6, createStock);
                break;
            case "1 D":
                Utils.getCoinInfoByHours(model.coinName, model.targetCoinName, 24, createStock);
                break;
            case "7 D":
                Utils.getCoinInfoByDays(model.coinName, model.targetCoinName, 7, createStock);
                break;
            case "30 D":
                Utils.getCoinInfoByDays(model.coinName, model.targetCoinName, 30, createStock);
                break;
            case "6 M":
                Utils.getCoinInfoByDays(model.coinName, model.targetCoinName, 180, createStock);
                break;
            case "1 Y":
                Utils.getCoinInfoByDays(model.coinName, model.targetCoinName, 365, createStock);
                break;
        }
    }
}
