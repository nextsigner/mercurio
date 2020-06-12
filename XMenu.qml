import QtQuick 2.0
Item {
    id: r
    width: parent.width
    height: parent.height
    property alias posY: flMenu.contentY
    property var arrayQmls: []
    property var arrayTipos: []
    property var arrayNumMods: []
    property var arrayLabels: []
    property string cTipo: ''
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
            spacing: app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            BotonUX{
                anchors.left: parent.left
                text: 'atras'
                fontSize: app.fs
                onClicked: {
                    app.mod=-1
                }
                visible: app.mod===-2 || app.mod===-3
            }
            Item{
                width: 1
                height: app.fs
            }
            Repeater{
                id: repIconMenu
                model: r.arrayLabels//['Significado de los Signos', 'Significado de los Planetas', 'Significado de las Casas', 'Lilith en las Casas', 'Quirón en las Casas', 'Tránsito Lunar', 'Tránsitos']
                BotonUX{
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: modelData//+' r:'+r.arrayTipos[index]
                    fontSize: app.rot?app.fs:app.fs*1.4
                    onClicked: {
                        app.mod=r.arrayNumMods[index]
                    }
                    visible: r.arrayTipos[index]===r.cTipo
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
            r.arrayTipos.push(json['mods']['mod'+i].tipo)
            r.arrayNumMods.push(json['mods']['mod'+i].numMod)
        }
        repIconMenu.model = r.arrayLabels
        r.arrayQmls=al
        //logView.showLog('Qmls: '+(''+al).split(',').join(' '))
    }
}
