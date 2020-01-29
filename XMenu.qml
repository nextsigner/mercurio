import QtQuick 2.0
import "qrc:/"

Item {
    id: r
    width: parent.width
    height: parent.height
    property alias posY: flMenu.contentY
    Flickable{
        id: flMenu
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: app.fs*8
        width: r.width
        height: r.height
        contentHeight: colMenu.height
        Column{
            id: colMenu
            spacing: app.rot?app.fs*0.25:app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            Repeater{
                id: repIconMenu
                model: ['Significado de los Planetas', 'Significado de las Casas', 'Lilith en las Casas', 'Quirón en las Casas', 'Tránsito Lunar', 'Tránsitos']
                BotonUX{
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: modelData
                    fontSize: app.rot?app.fs:app.fs*2
                    onClicked: app.mod=index
                }
            }
        }
    }
}
