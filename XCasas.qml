import QtQuick 2.0
import "qrc:/"

Item {
    id: r
    width: parent.width
    height: parent.height
    Grid{
        visible: app.cCasa===-1
        anchors.centerIn: parent
        columns: app.rot?6:3
        spacing: app.rot?app.fs*0.25:app.fs
        Repeater{
            id: repIconCasas
            model: 12
            BotonUX{
                width: app.rot?app.fs*4:app.fs*8
                height: width
                text: "Casa "+parseInt(modelData + 1)
                fontSize: app.rot?app.fs:app.fs*2
                onClicked: app.cCasa=index
            }
        }
    }
    Item{
        id: xDataCasas
        visible: app.cCasa!==-1
        Repeater{
            id: repDataCasas
            Rectangle{
                visible: app.cCasa===index
                width: xApp.width
                height: xApp.height
                radius: app.fs*0.5
                color: app.c1
                onVisibleChanged: {
                    if(visible){
                        unik.speak((''+modelData).replace(/<br \/>/g, '        '))
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
                                    app.cCasa=-1
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
                                    unik.speak((''+modelData).replace(/<br \/>/g, '        '))
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
        let d1=unik.getFile('dataCasas.json')
        let json = JSON.parse(d1)
        for(let i=1;i<=12;i++){
            console.log('D: '+json['casas']['casa'+i])
            arrayDataCasas.push(json['casas']['casa'+i])
        }
        repDataCasas.model = app.arrayDataCasas
    }
}
