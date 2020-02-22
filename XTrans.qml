import QtQuick 2.0
import "qrc:/"

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    property int cGradoLuna: -1
    property string cSignoLuna: ''
    MouseArea{
        anchors.fill: r
    }
    Flickable{
        id:flTrans
        width:r.width
        height: r.height
        contentWidth:r.width
        contentHeight:colTrans.height+app.fs*4 
    Column{
        id:colTrans
        spacing: app.fs
        anchors.centerIn: parent
        Item{width: 1;height: app.fs*0.5}
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
            text: '<b>Tránsitos</b>'
            color: app.c2
            font.pixelSize: app.fs*2
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Column{
            spacing: app.fs*0.5
            anchors.horizontalCenter: parent.horizontalCenter
            Repeater{
                id: repTrans
                property var arrayGrados: []
                property var arraySignos: []
                Rectangle{
                    width: rowDataTrans.width+app.fs*2
                    height: app.fs*2.5
                    color: app.c1
                    border.width: 2
                    border.color: app.c2
                    radius: app.fs*0.25
                    anchors.horizontalCenter: parent.horizontalCenter
                    Row{
                        id: rowDataTrans
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        UText{
                            text: modelData
                            font.pixelSize: app.fs
                        }
                        UText{
                            text: repTrans.arrayGrados[index]
                            font.pixelSize: app.fs
                        }
                        UText{
                            text: repTrans.arraySignos[index]
                            font.pixelSize: app.fs
                        }
                    }
                }
            }
        }

    }
    }
    Component.onCompleted: {
        getTransNow()
    }
    function speak(text){
        let s = (''+text)
        unik.speak(s)
    }
    function getTransNow(){
        repTrans.model= []
        repTrans.arrayGrados= []
        repTrans.arraySignos= []
        var req = new XMLHttpRequest();
        req.open('GET', 'https://www.astro.com/h/awt/ppos2_s.htm?code=f0aa269af58bda9dbf95d64c2a4e8a07', true);
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                if(req.status === 200){
                    let m0= req.responseText.split('<tr>')
                    for(let i=0;i<12;i++){
                        let d0 = (''+m0[i+2])
                        let m1= d0.split('<td')

                        //img
                        //let d = 'm1[1]'

                        //Nombre Planeta
                        //let d = 'm1[2]'

                        //Grados
                        let g0=m1[3].split('>')
                        let g1=g0[1].split('<')
                        repTrans.arrayGrados.push(' está a °'+g1[0]+ ' de ')

                        //Signo
                        let s0=m1[4].split('alt=\"')
                        let s1=s0[1].split('\"')
                        repTrans.arraySignos.push(s1[0])

                        //logView.showLog(s0)
                    }
                    repTrans.model= ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Jupiter', 'Saturno', 'Urano', 'Neptuno', 'Pluton', 'Nodo Norte', 'Quirón']

                }else{
                    logView.showLog("Error loading page\n");
                }
            }
        };
        req.send(null);
    }
}
