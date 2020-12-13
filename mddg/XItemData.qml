import QtQuick 2.0

Rectangle {
    id:r
    width: parent.width-app.fs
    height: textData.contentHeight+app.fs*2
    color: app.c1
    anchors.horizontalCenter: parent.horizontalCenter
    property string text
    border.width: 2
    border.color: app.c2
    radius: app.fs
    Text{
        id: textData
        text: r.text
        font.pixelSize: apps.fs
        color: app.c2
        width: r.width-apps.fs
        wrapMode: Text.WordWrap
        anchors.centerIn: parent
    }
}
