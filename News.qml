import QtQuick 2.9
import QtQuick.XmlListModel 2.0
import QtQuick.Window 2.1
import "./content"
import "./Models/JSONListModel"

Rectangle {
    id: window

    width: 800
    height: 480

    property string currentFeed: rssFeeds.get(0).feed
    property bool loading: feedModel.status === XmlListModel.Loading
    property bool isPortrait: Screen.primaryOrientation === Qt.PortraitOrientation

    onLoadingChanged: {
        if (feedModel.status == XmlListModel.Ready)
            newsList.positionViewAtBeginning()
    }

    RssFeeds { id: rssFeeds }

    XmlListModel {
        id: feedModel

        source: "http://" + window.currentFeed
        query: "/rss/channel/item[child::media:content]"
        namespaceDeclarations: "declare namespace media = 'http://search.yahoo.com/mrss/';"

        XmlRole { name: "title"; query: "title/string()" }
        // Remove any links from the description
        XmlRole { name: "description"; query: "fn:replace(description/string(), '\&lt;a href=.*\/a\&gt;', '')" }
        XmlRole { name: "image"; query: "media:content/@url/string()" }
        XmlRole { name: "link"; query: "link/string()" }
        XmlRole { name: "pubDate"; query: "pubDate/string()" }
    }

    ListView {
        id: categories
        property int itemWidth: 190

        width: isPortrait ? parent.width : itemWidth
        height: isPortrait ? itemWidth : parent.height
        orientation: isPortrait ? ListView.Horizontal : ListView.Vertical
        anchors.top: parent.top
        model: rssFeeds
        delegate: CategoryDelegate { itemSize: categories.itemWidth }
        spacing: 3
    }

    ScrollBar {
        id: listScrollBar

        orientation: isPortrait ? Qt.Horizontal : Qt.Vertical
        height: isPortrait ? 8 : categories.height;
        width: isPortrait ? categories.width : 8
        scrollArea: categories;
        anchors.right: categories.right
    }

    ListView {
        id: newsList

        anchors.left: isPortrait ? window.left : categories.right
        anchors.right: window.right
        anchors.top: isPortrait ? categories.bottom : window.top
        anchors.bottom: window.bottom
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        clip: isPortrait
        model: feedModel
        footer: footerText
        delegate: NewsDelegate {}
    }

    ScrollBar {
        scrollArea: newsList
        width: 8
        anchors.right: window.right
        anchors.top: isPortrait ? categories.bottom : window.top
        anchors.bottom: window.bottom
    }

    Component {
        id: footerText

        Rectangle {
            width: parent.width
            height: closeButton.height
            color: "lightgray"

            Text {
                text: "RSS Feed from Yahoo News"
                anchors.centerIn: parent
                font.pixelSize: 14
            }
        }
    }

    Image {
        id: closeButton
        //source: "content/images/btn_close.png"
        scale: 0.8
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 4
        opacity: (isPortrait && categories.moving) ? 0.2 : 1.0
        Behavior on opacity {
            NumberAnimation { duration: 300; easing.type: Easing.OutSine }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                Qt.quit()
            }
        }
    }
}
