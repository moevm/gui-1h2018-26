import QtQuick 2.9
import QtQuick.XmlListModel 2.0
import QtQuick.Window 2.1
import QtQuick.Layouts 1.3
import "./content"
import "./Models/JSONListModel"
import "./Models"
import "./Views"
import "./Delegates"
import "./Models/JSONListModel/CryptoApi.js" as Utils

Rectangle {
    id: window

    width: 800
    height: 480

    property string currentFeed: ""
    property bool loading: feedModel.status === XmlListModel.Loading
    property bool isPortrait: Screen.primaryOrientation === Qt.PortraitOrientation

    onLoadingChanged: {
        if (feedModel.status == XmlListModel.Ready)
            newsList.positionViewAtBeginning()
    }


    Text {
        id: categoriesTitle
        color: "#000000"
        font.pointSize: 14
        //font.weight: Font.Bold
        verticalAlignment: Text.AlignVCenter
        maximumLineCount: 1
        text: "Categories"
        wrapMode: Text.Wrap
        anchors.margins: 10
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 10
    }

    RSSCAtregoryListModel {
        id: rssFeeds
        onDataChanged: {
            window.currentFeed = rssFeeds.data(0, "categoryName");
        }
    }

    RSSCategoriesView {
        model: rssFeeds
        id: categories
        width: 160
        anchors.top: categoriesTitle.bottom//parent.top
        anchors.bottom: parent.bottom
        anchors.margins: 10
        anchors.topMargin: 10
    }

    ScrollBar {
        id: listScrollBar

        orientation: isPortrait ? Qt.Horizontal : Qt.Vertical
        height: categories.height;
        width: 8;
        scrollArea: categories;
        anchors.right: categories.right
        anchors.top: categories.top
    }

    ListView {
        id: newsList

        anchors.left: categories.right
        anchors.right: window.right
        anchors.top: categoriesTitle.bottom//anchors.top: window.top
        anchors.bottom: window.bottom
        anchors.leftMargin: 10
        anchors.topMargin: 10
        anchors.rightMargin: 40
        clip: isPortrait
        model: feedModel

        delegate: Rectangle {
                  width: parent.width
                  color: "transparent"
                  height: 200
                  GridLayout {
                      id: stockGrid
                      columns: 2
                      rows: 3
                      width: parent.width
                      height: parent.height

                      Image {
                          id: coinImage
                          fillMode: Image.PreserveAspectFit
                          height: 90
                          Layout.rowSpan: 3
                          sourceSize.height: 90
                          sourceSize.width: 90
                          Layout.margins: 10
                          width: 70
                          source: imageurl
                      }

                      Text {
                          id: newsTitle
                          Layout.margins: 10
                          Layout.rowSpan: 1
                          Layout.maximumWidth: newsList.width - 70
                          color: "#000000"
                          //font.family: Settings.fontFamily
                          font.pointSize: 14
                          //font.weight: Font.Bold
                          verticalAlignment: Text.AlignVCenter
                          maximumLineCount: 1
                          text: title
                          wrapMode: Text.Wrap
                      }

                      Text {
                          id: newsBody
                          Layout.alignment: Qt.AlignLeft
                          Layout.margins: 10
                          color: "#000000"
                          Layout.maximumWidth: newsList.width - 70
                          //font.family: Settings.fontFamily
                          font.pointSize: 12
                          //font.weight: Font.Bold
                          height: 100
                          maximumLineCount: 4
                          verticalAlignment: Text.AlignVCenter
                          horizontalAlignment: Text.AlignLeft
                          wrapMode: Text.Wrap
                          elide: Text.ElideLeft
                          text: body
                      }

                      Text {
                          id: newsUrl
                          Layout.alignment: Qt.AlignLeft
                          Layout.margins: 10
                          Layout.maximumWidth: newsList.width - 70
                          color: "#0000ff"
                          font.pointSize: 12
                          verticalAlignment: Text.AlignVCenter
                          horizontalAlignment: Text.AlignLeft
                          wrapMode: Text.Wrap
                          elide: Text.ElideLeft
                          text: url
                          maximumLineCount: 1
                          MouseArea {
                              anchors.fill: parent;
                              onClicked: {
                                      Qt.openUrlExternally(newsUrl.text);
                              }
                          }
                      }
                  }

                  Rectangle {
                      id: endingLine
                      anchors.top: stockGrid.bottom
                      height: 1
                      width: parent.width
                      color: "#d7d7d7"
                  }
              }
    }

    ListModel {
        id: feedModel
        property string currentCategory: categories.currentCategory

        onCurrentCategoryChanged: {
            feedModel.update();
        }

        function update(){
            feedModel.clear();
            Utils.getFeedByCategory(currentCategory, acceptResponse);
        }

        function acceptResponse(response){
            var responseObject = JSON.parse(response);


            for (var index in responseObject)
                feedModel.append(responseObject[index]);
        }

    }

    ScrollBar {
        scrollArea: newsList
        width: 8
        anchors.right: window.right
        anchors.top: isPortrait ? categories.bottom : window.top
        anchors.bottom: window.bottom
    }
}


