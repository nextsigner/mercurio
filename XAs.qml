import QtQuick 2.0

Item{
    id: r
    width: parent.width-r.fs*3-(r.fs*pos)
    height: 1
    anchors.centerIn: parent
    property string astro
    property int fs
    property int pos: 1
    Item{
        width: r.fs
        height: width
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        Image {
            source: "./resources/imgs/planetas/"+r.astro+".svg"
            width: parent.width
            height: width
            anchors.centerIn: parent
            rotation: 0-parent.parent.rotation
        }
    }
}
