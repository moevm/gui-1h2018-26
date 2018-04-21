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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import "../Models"
import "../Delegates"
import "../Models/JSONListModel/CryptoApi.js" as Utils

Rectangle {
    id: root
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    color: "white"
    property string currentCoinName: ""
    property string targetCoinName: ""
    RowLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 10
        id: rofl;
        spacing: 28

        Text {
            id: timeSpan
            color: "#000000"
            font.pointSize: 14
            //font.weight: Font.Bold
            verticalAlignment: Text.AlignVCenter
            maximumLineCount: 1
            text: "Target currency:"
            wrapMode: Text.Wrap
            //anchors.margins: 10
        }

        ComboBox {
            id: selector
            model: ["USD", "ETH", "RUB", "BTC", "EUR", "AUD", "BRL", "CAD", "CHF", "GBP",
                "HKD"]
            onCurrentTextChanged: {
                stockModel.targetCoin = selector.currentText;
                stockModel.loadData();
                root.targetCoinName = stockModel.targetCoin;
            }
        }
    }
    ListView {
        id: view
        anchors.top: rofl.bottom;
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 10
        clip: true
        keyNavigationWraps: true
        highlightMoveDuration: 0
        focus: true
        snapMode: ListView.NoSnap
        model: StockListModel {
            id: stockModel;
        }
        currentIndex: -1 // Don't pre-select any item
        cacheBuffer: 1000;
        onCurrentIndexChanged: {
            if (currentItem) {
                root.targetCoinName = model.targetCoin;
                root.currentCoinName = model.get(currentIndex).Name;
            }
        }

        delegate: StockListDelegate {

        }

        highlight: Rectangle {
            width: view.width
            color: "#eeeeee"
        }

        Component.onCompleted: {
            model.loadData();
        }
    }
}
