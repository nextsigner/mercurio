import QtQuick 2.0
import QtQuick.Controls 2.0
ApplicationWindow{
	id: app
	visible: true
    visibility: "FullScreen"
    color:"green"
	
    Column{
        anchors.centerIn: parent
        Text{
            text: "Hola Natalia! 1"
            color: "white"
            font.pixelSize: 30

        }
        Text{
            text: "Hola Natalia! 2"
            color: "white"
            font.pixelSize: 30

        }
        Text{
            text: "Hola Natalia! 3"
            color: "white"
            font.pixelSize: 30

        }
        Text{
            text: "Hola Natalia! 4"
            color: "white"
            font.pixelSize: 30

        }
    }


    MouseArea{
        anchors.fill: parent
        onDoubleClicked: Qt.quit()
    }
}
