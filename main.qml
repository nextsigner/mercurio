import QtQuick 2.0
import QtQuick.Controls 2.0
ApplicationWindow{
	id: app
	visible: true
    visibility: "FullScreen"
    color:"green"
	
	Text{
		text: "Hola Natalia!"
		color: "white"
		font.pixelSize: 30
        anchors.centerIn: parent
	}
    MouseArea{
        anchors.fill: parent
        onDoubleClicked: Qt.quit()
    }
}
