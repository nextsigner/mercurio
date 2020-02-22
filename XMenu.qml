import QtQuick 2.0
Item {
    id: r
    width: parent.width
    height: parent.height
    property alias posY: flMenu.contentY
    property var arrayQmls: []
    property var arrayLabels: []
    Flickable{
        id: flMenu
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: app.fs*8
        width: r.width
        height: r.height
        contentHeight: colMenu.height*1.4
        Column{
            id: colMenu
            spacing: app.rot?app.fs*0.25:app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            Repeater{
                id: repIconMenu
                model: r.arrayLabels//['Significado de los Signos', 'Significado de los Planetas', 'Significado de las Casas', 'Lilith en las Casas', 'Quirón en las Casas', 'Tránsito Lunar', 'Tránsitos']
                BotonUX{
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: modelData
                    fontSize: app.rot?app.fs:app.fs*1.4
                    onClicked: app.mod=index
                }
            }
        }
    }
    Component.onCompleted: {
        let d1=unik.fileExist('menu.json')?unik.getFile('menu.json'):'{}'
        let json = JSON.parse(d1)
        let al=[]
        for(let i=0;i<=Object.keys(json['mods']).length-1;i++){
            al.push(json['mods']['mod'+i].qml)
            r.arrayLabels.push(json['mods']['mod'+i].label)
        }
        repIconMenu.model = r.arrayLabels
        r.arrayQmls=al
    }
}
