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
import QtCharts 2.1

import "."

Item {
    id: root
    //![1]
    ChartView {
        title: "Please select any currency"
        anchors.fill: parent
        legend.visible: false
        antialiasing: true
        id: chart

        axes: [
            DateTimeAxis {
                id: xAxis
                //format: "yyyy MMM"
                tickCount: 5
            },

            ValueAxis {
                id: yAxis
                //min: 0
                //max: 150
            }
        ]
    }
    // DateTimeAxis is based on QDateTimes so we must convert our JavaScript dates to
    // milliseconds since epoch to make them match the DateTimeAxis values
    function toMsecsSinceEpoch(date) {
        var msecs = date.getTime();
        return msecs;
    }
    //![1]

    function findMin(elements, prop, max){
        var min = max;
        for(var index in elements)
        {
            if(elements[index][prop] < min)
                min = elements[index][prop];
        }
        return min;
    }

    function findMax(elements, prop){
        var max = -1;
        for(var index in elements)
        {
            if(elements[index][prop] > max)
                max = elements[index][prop];
        }
        return max;
    }

    function fromMillesecondsToDate(milleseconds){
        return new Date(milleseconds);
    }

    function setAxesFormat(title){
        if(title.search("1 D") != -1 || title.search("6 H") != -1)
            return "hh:MM"
        if(title.search("7 D") != -1 || title.search("30 D") != -1)
            return "MMM dd";
        return "yyyy MMM";
    }

<<<<<<< HEAD
    function computeMovingAverage(elements){
        var series = chart.createSeries(ChartView.SeriesTypeLine, "Moving Average", xAxis, yAxis);
        series.pointsVisible = false;
        series.color = Qt.rgba(1., 0, 0, 1);
        var result = []
        for(var i = 0; i < elements.length; i++){
            if(i == 0){
                result.push({time: elements[i]["time"], open: elements[i]["open"] })
                continue
            }

            result.push({time: elements[i]["time"], open: (elements[i]["open"] + result[i - 1].open * i)/(i + 1)})
        }

        for(var index in result)
        {
            var date = result[index]["time"] * 1000;
            var open = result[index]["open"];
            series.append(date, open);
        }
    }


    function updateStock(elements, title) {
        chart.removeAllSeries();
        computeMovingAverage(elements);
=======
    function updateStock(elements, title) {
        chart.removeAllSeries();
>>>>>>> e40046b4513f4d527fbf662438cfbe87fcde1a6a
        xAxis.tickCount = 5;
        yAxis.max = findMax(elements, "open");
        xAxis.max = fromMillesecondsToDate(findMax(elements, "time") * 1000);
        yAxis.min = findMin(elements, "open", yAxis.max);
        xAxis.min = fromMillesecondsToDate( findMin(elements, "time", xAxis.max) * 1000);
        xAxis.format = setAxesFormat(title);
<<<<<<< HEAD
        var series = chart.createSeries(ChartView.SeriesTypeLine, "Stock", xAxis, yAxis);
        series.pointsVisible = true;
        series.color = Qt.rgba(0, 0, 1, 1);
=======
        var series = chart.createSeries(ChartView.SeriesTypeLine, "line", xAxis, yAxis);
        series.pointsVisible = true;
        series.color = Qt.rgba(Math.random(),Math.random(),Math.random(),1);
>>>>>>> e40046b4513f4d527fbf662438cfbe87fcde1a6a
        for(var index in elements)
        {
            var date = elements[index]["time"] * 1000;
            var open = elements[index]["open"];
            series.append(date, open);
        }
        series.pointsVisible = true;
        chart.title = title;
    }

}
