import QtQuick 2.0

Item{
    id: r
    width: parent.width-r.fs*3-(r.fs*2*objData.p)
    height: 1
    anchors.centerIn: parent
    property string astro
    property string numSign
    property int fs
    property var objData: ({})
    property int pos: 1
    property int g: -1
    property int m: -1
    property int numAstro: -1

    Item{
        width: r.fs
        height: width
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                r.parent.cAs=r
            }
            onExited: {
                //r.parent.cAs=r.parent
            }
            onClicked: r.parent.pressed(r)
        }
        Image {
            id: img
            source: "./resources/imgs/planetas/"+r.astro+".svg"
            width: parent.width
            height: width
            anchors.centerIn: parent
            rotation: 0-parent.parent.rotation
        }
    }
}
