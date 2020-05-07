import QtQuick 2.12
import QtQuick.Controls 2.12
import "func.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    property int cNumSigno: -1
    property int cGradoLuna: -1
    property string cSignoLuna: ''
    property var jsonDataTransLunar: '{}'
    onVisibleChanged: {
        if(visible)getTransNow()
    }
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
                        app.mod=-2
                        JS.speak('atras')
                    }
                }
                BotonUX{
                    visible: cbAsc.currentIndex!==0
                    text: 'Detener Voz'
                    fontSize: app.rot?app.fs*0.5:app.fs
                    onClicked: {
                        JS.speak('Detenido.')
                    }
                }
                BotonUX{
                    visible: cbAsc.currentIndex!==0
                    text: 'Leer'
                    fontSize: app.rot?app.fs*0.5:app.fs
                    onClicked: {
                        r.speak(resTransLunar.text)
                    }
                }
            }
            Text{
               text: '<b>Tránsito Lunar</b>'
                color: app.c2
                font.pixelSize: app.fs*1.5
                width: r.width-app.fs
                wrapMode: Text.WordWrap
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Column{
                spacing: app.fs
                anchors.horizontalCenter: parent.horizontalCenter               
                UComboBox{
                    id: cbAsc
                    fontSize: app.fs*1.5
                    contentHeight: r.height*0.5
                    z: resTransLunar.z+1
                    model: ['Seleccionar', 'Natalia', 'Ricardo', 'Nico', 'Fer', 'Dylan', 'Bruno', 'Hugo', 'Ely Dorgan', 'Mario Pizarro', 'Ascendente '+app.signos[0], 'Ascendente '+app.signos[1], 'Ascendente '+app.signos[2], 'Ascendente '+app.signos[3], 'Ascendente '+app.signos[4], 'Ascendente '+app.signos[5], 'Ascendente '+app.signos[6], 'Ascendente '+app.signos[7], 'Ascendente '+app.signos[8], 'Ascendente '+app.signos[9], 'Ascendente '+app.signos[10], 'Ascendente '+app.signos[11]]
                    property var arrayAsc: [0,11, 11, 5, 4, 2, 7, 12, 1, 11, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                    width: r.width-app.fs
                    anchors.horizontalCenter: parent.horizontalCenter
                    onCurrentIndexChanged: {
                        if(currentIndex===0)return
                        let numAsc=parseInt(12 - arrayAsc[currentIndex] + r.cNumSigno)
                        //console.log('1::::::->'+currentIndex)
                        //console.log('2::::::->'+r.cNumSigno)
                        //console.log('3::::::->'+numAsc)
                        let numCasa = getNumCasa(app.signos[parseInt(arrayAsc[currentIndex ] - 1)], r.cNumSigno)
                        if(numCasa>12){
                            numCasa=numCasa-12
                        }
                        //console.log('4::::::->'+numCasa)
                        let pp=''
                        let pf=''
                        let destinatario=''
                        if(model[currentIndex].indexOf('Ascendente')===0){
                            destinatario='la persona con '+model[currentIndex]
                        }else{
                            destinatario=model[currentIndex]
                        }
                        pp='Actualmente '+destinatario
                        let gradoActualDeLuna = r.cGradoLuna
                        let proximaCasa=0
                        if(numCasa>=12){
                            proximaCasa=12-numCasa+1
                        }else{
                            proximaCasa=numCasa+1
                        }
                        let proximoSigno=0
                        if(r.cNumSigno>=12){
                            proximoSigno=1
                        }else{
                            proximoSigno=r.cNumSigno
                        }
                        if(gradoActualDeLuna<12){
                            pf+='La persona va a estar así hoy y mañana.'
                        }else if(gradoActualDeLuna>=12&&gradoActualDeLuna<24){
                            pf+='La persona va a estar así hoy y mañana cambia a la casa número '+proximaCasa+' en el signo '+app.signos[proximoSigno]
                        }else if(gradoActualDeLuna>=24&&gradoActualDeLuna<28){
                            pf+='La persona está así hoy y  pocas horas cambia a la casa número '+proximaCasa+' en el signo '+app.signos[proximoSigno]
                        }else if(gradoActualDeLuna>=28){
                            pf+='La persona en estos momentos está cambiando a la casa número '+proximaCasa+' en el signo '+app.signos[proximoSigno]+'.'
                        }else{
                            pf+='La persona va a estar así hoy'//+'r.cNumSigno='+r.cNumSigno+' proximoSigno='+proximoSigno+' signo='+app.signos[proximoSigno -1]
                        }
                        resTransLunar.text='<br />'+pp+' tiene la Luna en tránsito en el grado '+gradoActualDeLuna+' de la casa número '+numCasa+' en el signo  '+app.signos[r.cNumSigno - 1]+'.<br />'
                        resTransLunar.text+='<br />'+getAsunto(numCasa, app.signos[r.cNumSigno - 1], destinatario, pf)
                        //resTransLunar.text+='<br />'+pf+'<br /><br />'
                        r.speak(resTransLunar.text)
                    }
                }
                UText{
                    id: resTransLunar
                    visible: cbAsc.currentIndex!==0
                    width: r.width-app.fs
                    text: 'Seleccionar un nombre o Ascendente'
                    font.pixelSize: app.fs*1.5
                    wrapMode: Text.WordWrap
                    anchors.horizontalCenter: parent.horizontalCenter
                }

            }

        }
    }
    Component.onCompleted: {
        getTransNow()
        let d1=unik.getFile('dataTransLunar.json').replace(/\n/g,'<br />').replace('}}<br />','}}')
        jsonDataTransLunar = JSON.parse(d1.replace(/\n\n/g, '\n'))
    }
    function speak(text){
        let s = ''+text.replace(/<br \/>/g, '')
        JS.speak(s)
    }
    function getNumCasa(asc, currentSigno){
        let ci = app.signos.indexOf(asc)
        let numCasa = 12 -  ci  + currentSigno
        //console.log('ci0::::::::::::::'+asc)
        //console.log('ci::::::::::::::'+ci)
        return numCasa
    }
    function setDestinatario(data, dest){
        let d0=data.replace(/\ndestinatario/g, '<br />'+capital_letter(dest))
        let d1=d0.replace(/destinatario/g, capital_letter(dest))
        return d1;
    }
    function getAsunto(casa, signo, destinatario, pf){
        let d=jsonDataTransLunar['items']['casa'+casa].data
        d+='<br /><br />'+pf
        d+='<br /><br />'+jsonDataTransLunar['items']['casa'+casa][(''+signo).toLowerCase()]
        return setDestinatario(d, destinatario)
    }
    function getTransNow(){
        var req = new XMLHttpRequest();
        let d = new Date(Date.now())
        req.open('GET', 'https://www.astro.com/h/awt/ppos2_s.htm?code=f0aa269af58bda9dbf95d64c2a4e8a07&r='+d.getTime(), true);
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
                        //logView.showLog('XXX'+g1[0]+'XXX')
                        if(i===1){
                            r.cGradoLuna=parseInt(g1[0])

                        //repTrans.arrayGrados.push(' está a °'+g1[0]+ ' de ')

                        //Signo
                        let s0=m1[4].split('alt=\"')
                        let s1=s0[1].split('\"')
                        let s2=''+s1[0]

                        cNumSigno=parseInt(app.signos.indexOf(s2) + 1)
                      }
                    }
                }else{
                    logView.showLog("Error loading page\n");
                }
            }
        };
        req.send(null);
    }
    function capital_letter(str){
        str = str.split(" ");
        for (let i = 0, x = str.length; i < x; i++) {
            str[i] = str[i][0].toUpperCase() + str[i].substr(1);
        }
        return str.join(" ");
    }
}
