import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    MouseArea{
        anchors.fill: r
    }
    Flickable{
        width: r.width
        height: r.height
        contentWidth: width
        contentHeight: col.height+app.fs*6
        Column{
            id: col
            spacing: app.fs*2
            anchors.horizontalCenter: parent.horizontalCenter
            Item{width: 1;height: app.fs*0.5}
            Flow{
                width:r.width-app.fs
                spacing: app.fs
                BotonUX{
                    text: 'Atras'
                    fontSize: app.rot?app.fs*0.5:app.fs
                    onClicked: {
                        app.mod=-1
                        unik.speak('atras')
                    }
                }
            }
            Text{
                width: xApp.width-app.fs*2
                text: '<b>Más Información</b>'
                color: app.c2
                font.pixelSize: app.fs*2
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Column{
                spacing: app.fs
                anchors.horizontalCenter: parent.horizontalCenter
                UText{
                    id: txtInfo
                    width: r.width-app.fs
                    font.pixelSize: app.fs
                    wrapMode: Text.WordWrap
                    anchors.horizontalCenter: parent.horizontalCenter
                    onLinkActivated: Qt.openUrlExternally(link)
                }
            }
        }
    }
    Component.onCompleted: {
        txtInfo.text='Unik Qml Engine y Mercurio son aplicaciones desarrolladas con el frameworik Qt Open Source por @nextsigner y su equipo de colaboradores.<br />Para más información sobre el Qt Project diríjase a <a href="http://www.qt.io/">www.qt.io/</a><br /><br />'
        txtInfo.text+='<b>Colaboradores</b><br /><br /><ul><li>Natalia Soledad Pintos</li><li>Ivonne Pizarro</li></ul><br /><br />'
        txtInfo.text+='Para más información sobre Mercurio puedes unirte a el grupo de Whatsapp <b>Usuarios de Mercurio</b>.<br /><br />Enlace para unirse al grupo de Whatsapp: <a href="https://chat.whatsapp.com/IBHvkroLSzi0xYR6ezj4XG">https://chat.whatsapp.com/</a><br /><br /><b>Otras vías de comunicación</b><br /><br />E-Mail: nextsigner@gmail.com<br /><br />Whatsapp: +54 11 3802 4370<br /><br />'
    }
}
