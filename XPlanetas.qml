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
            onClicked: {
                app.mod=-1
                unik.speak('atras')
            }
        }
        Text{
            width: xApp.width-app.fs*2
            text: '<b>Significados de los Planetas</b>'
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
                model: ['Sol', 'Luna', 'Mercurio', 'Venus', 'Martes', 'Jupiter', 'Saturno', 'Urano', 'Neptuno', 'Pluton']
                BotonUX{
                    width: app.rot?app.fs*4:app.fs*8
                    height: width
                    text: modelData
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
                        r.speak(modelData)
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
                                    //let s = (''+modelData).replace(/<br \/>/g, '        ').replace(/<b>/g, '').replace(/<\/b>/g, '')
                                    //logView.showLog(s)
                                    r.speak(modelData)
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
        let d1=unik.getFile('dataPlanetas.json')
        let json = JSON.parse(d1)
        for(let i=1;i<=10;i++){
            console.log('D: '+json['items']['item'+i])
            arrayDataCasas.push(json['items']['item'+i])
        }
        repDataCasas.model = r.arrayDataCasas
    }
    function speak(text){
        let s = (''+text).replace(/<br \/>/g, '        ').replace(/<b>/g, '').replace(/<\/b>/g, '').replace(/LILITH/g, 'la luna negra').replace(/Lilith/g, 'la luna negra').replace(/Casa IV/g, 'casa 4').replace(/Casa IX/g, 'casa 9').replace(/Casa III/g, 'casa 3').replace(/Casa II/g, 'casa 2').replace(/Casa I/g, 'casa 1').replace(/Casa V/g, 'casa 5').replace(/Casa VIII/g, 'casa 8').replace(/Casa VII/g, 'casa 7').replace(/Casa VI/g, 'casa 6').replace(/Casa X/g, 'casa 10').replace(/Casa XII/g, 'casa 12').replace(/Casa XI/g, 'casa 11').replace(/CASA IV/g, 'casa 4').replace(/CASA IX/g, 'casa 9').replace(/CASA III/g, 'casa 3').replace(/CASA II/g, 'casa 2').replace(/CASA I/g, 'casa 1').replace(/CASA V/g, 'casa 5').replace(/CASA VIII/g, 'casa 8').replace(/CASA VII/g, 'casa 7').replace(/CASA VI/g, 'casa 6').replace(/CASA X/g, 'casa 10').replace(/CASA XII/g, 'casa 12').replace(/CASA XI/g, 'casa 11')
        unik.speak(s)
    }
}
