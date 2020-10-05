import QtQuick 2.0
import "func.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    property int cCasa: -1
    property var arrayDataCasas: []
    MouseArea{
        anchors.fill: r
    }
    Column{
        spacing: app.fs
        anchors.centerIn: parent
        Item{width: 1;height: app.fs*0.5}
        BotonUX{
            text: 'Atras'
            fontSize: app.rot?app.fs:app.fs
            onClicked: {
                app.mod=-3
                JS.speak('atras')
            }
        }
        Text{
            text: '<b>Significado de las Casas</b>'
            color: app.c2
            font.pixelSize: app.fs
            width: r.width-app.fs
            wrapMode: Text.WordWrap
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Grid{
            visible: r.cCasa===-1
            anchors.horizontalCenter: parent.horizontalCenter
            columns: app.rot?6:3
            spacing: app.rot?app.fs*0.25:app.fs
            Repeater{
                id: repIconCasas
                model: 12
                BotonUX{
                    width: app.rot?app.fs*5:app.fs*5
                    height: width
                    text: "Casa "+parseInt(modelData + 1)
                    fontSize: app.rot?app.fs:app.fs
                    onClicked: r.cCasa=index
                }
            }
        }

    }
    Item{
        id: xDataCasas
        visible: r.cCasa!==-1
        Repeater{
            id: repDataCasas
            Rectangle{
                visible: r.cCasa===index
                width: xApp.width
                height: xApp.height
                radius: app.fs*0.5
                color: app.c1
                onVisibleChanged: {
                    if(visible){
                        let s = (''+modelData).replace(/<br \/>/g, '        ').replace(/<b>/g, '').replace(/<\/b>/g, '')
                        JS.speak(s)
                    }
                }
                Flickable{
                    anchors.top: parent.top
                    anchors.topMargin: app.fs*2
                    width: parent.width
                    height: parent.height
                    contentWidth: parent.width
                    contentHeight: colDataCasas.height+app.fs*6
                    Column{
                        id: colDataCasas
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: app.fs
                        Row{
                            spacing: app.fs
                            BotonUX{
                                text: 'Atras'
                                onClicked: {
                                    JS.speak('atras')
                                    r.cCasa=-1
                                }
                            }
                            BotonUX{
                                text: 'Detener Audio'
                                onClicked: {
                                    JS.speak('detenido')
                                }
                            }
                            BotonUX{
                                text: 'Leer'
                                onClicked: {
                                    let s = (''+modelData).replace(/<br \/>/g, '        ').replace(/<b>/g, '').replace(/<\/b>/g, '')
                                    //logView.showLog(s)
                                    JS.speak(s)
                                }
                            }
                        }
                        Item{width: 1; height: app.fs}
                        Text{
                            width: xApp.width-app.fs*2
                            text: modelData
                            color: app.c2
                            font.pixelSize: app.fs
                            wrapMode: Text.WordWrap
                            textFormat: Text.RichText
                        }
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        let d1=unik.getFile('dataCasas.json')
        let json = JSON.parse(d1)
        for(let i=1;i<=12;i++){
            //console.log('D: '+json['casas']['casa'+i])
            arrayDataCasas.push(json['casas']['casa'+i])
        }
        repDataCasas.model = r.arrayDataCasas
    }
}
