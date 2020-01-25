import QtQuick 2.0
import "qrc:/"

Item {
    id: r
    width: parent.width
    height: parent.height
    Column{
        anchors.centerIn: parent
        spacing: app.rot?app.fs*0.25:app.fs
        Repeater{
            id: repIconMenu
            model: ['Significado de las Casas', 'Lilith en las Casas']
            BotonUX{
                anchors.horizontalCenter: parent.horizontalCenter
                text: modelData
                fontSize: app.rot?app.fs:app.fs*2
                onClicked: app.mod=index
            }
        }
    }
}
