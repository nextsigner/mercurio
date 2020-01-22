import QtQuick 2.0
import QtQuick.Controls 2.0
ApplicationWindow{
    id: app
    visible: true
    visibility: "FullScreen"
    color:"green"

    Column{
        anchors.centerIn: parent
        Repeater{
            model: 12
            Text{
                text: "Casa "+modelData
                color: "white"
                font.pixelSize: 30

            }
        }
    }


    MouseArea{
        anchors.fill: parent
        onDoubleClicked: Qt.quit()
    }
}
