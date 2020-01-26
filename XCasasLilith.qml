import QtQuick 2.0
import "qrc:/"

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    property int cCasa: -1
    property var arrayDataCasas: []
    Column{
        spacing: app.fs
        anchors.centerIn: parent
        BotonUX{
            text: 'Atras'
            fontSize: app.rot?app.fs*0.5:app.fs
            onClicked: app.mod=-1
        }
        Text{
            width: xApp.width-app.fs*2
            text: '<b>Lilith en las Casas</b>'
            color: app.c2
            font.pixelSize: app.fs*2
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Grid{
            visible: r.cCasa===-1
            columns: app.rot?6:3
            spacing: app.rot?app.fs*0.25:app.fs
            anchors.horizontalCenter: parent.horizontalCenter
            Repeater{
                id: repIconCasas
                model: 12
                BotonUX{
                    width: app.rot?app.fs*4:app.fs*8
                    height: width
                    text: "Casa "+parseInt(modelData + 1)
                    fontSize: app.rot?app.fs:app.fs*2
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
                        let s = (''+modelData).replace(/<br \/>/g, '        ').replace(/<b>/g, '').replace(/<\/b>/g, '').replace(/LILITH/g, 'la luna negra').replace(/Lilith/g, 'la luna negra').replace(/Casa IV/g, 'casa 4').replace(/Casa IX/g, 'casa 9').replace(/Casa III/g, 'casa 3').replace(/Casa II/g, 'casa 2').replace(/Casa I/g, 'casa 1').replace(/Casa V/g, 'casa 5').replace(/Casa VIII/g, 'casa 8').replace(/Casa VII/g, 'casa 7').replace(/Casa VI/g, 'casa 6').replace(/Casa X/g, 'casa 10').replace(/Casa XII/g, 'casa 12').replace(/Casa XI/g, 'casa 11')
                        unik.speak(s)
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
                                    unik.speak('atras')
                                    r.cCasa=-1
                                }
                            }
                            BotonUX{
                                text: 'Detener Audio'
                                onClicked: {
                                    unik.speak('detenido')
                                }
                            }
                            BotonUX{
                                text: 'Leer'
                                onClicked: {
                                    let s = (''+modelData).replace(/<br \/>/g, '        ').replace(/<b>/g, '').replace(/<\/b>/g, '')
                                    //logView.showLog(s)
                                    unik.speak(s)
                                }
                            }
                        }
                        Item{width: 1; height: app.fs}
                        Text{
                            width: xApp.width-app.fs*2
                            text: modelData
                            color: app.c2
                            font.pixelSize: app.fs*2
                            wrapMode: Text.WordWrap
                            textFormat: Text.RichText
                        }
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        let d1=unik.getFile('dataCasasLilith.json')
        let json = JSON.parse(d1)
        for(let i=1;i<=12;i++){
            console.log('D: '+json['casas']['casa'+i])
            arrayDataCasas.push(json['casas']['casa'+i])
        }
        repDataCasas.model = r.arrayDataCasas
    }
}
