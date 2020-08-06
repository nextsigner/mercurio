import QtQuick 2.0

Item {
    id: r
    anchors.fill: parent
    visible: false
    property string ciudad: '...????'
    MouseArea{
        anchors.fill: r
        onClicked: r.visible=false
    }
    Rectangle{
        anchors.fill: r
        color: app.c1
        opacity: 0.5
    }
    UText{
        width: r.width*0.8
        text: 'Cargando Coordenadas de '+r.ciudad
        color: app.c2
        font.pixelSize: app.fs*2
        wrapMode: Text.WordWrap
        anchors.centerIn: parent
    }
}
