import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/"

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    property int cNumSigno: -1
    property int cGradoLuna: -1
    property string cSignoLuna: ''

    property string serverUrl: app.serverUrl
    property int portRequest: app.portRequest
    property int portFiles: app.portFiles
    property string lon: ''
    property string lat: ''

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
            Flow{
                width:r.width-app.fs
                spacing: app.fs
                BotonUX{
                    text: 'Atras'
                    fontSize: app.rot?app.fs*0.5:app.fs
                    onClicked: {
                        unik.speak('atras')
                        app.mod=-2
                        r.destroy(10)
                    }
                }
                BotonUX{
                    text: 'Detener Voz'
                    fontSize: app.rot?app.fs*0.5:app.fs
                    onClicked: {
                        unik.speak('Detenido.')
                    }
                }
//                BotonUX{
//                    text: 'Leer'
//                    fontSize: app.rot?app.fs*0.5:app.fs
//                    onClicked: {
//                        r.speak(resCarta.text)
//                    }
//                }
            }
            Text{
                width: xApp.width-app.fs*2
                text: '<b>Crear Carta Natal</b>'
                color: app.c2
                font.pixelSize: app.fs*2
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Column{
                spacing: app.fs*2
                anchors.horizontalCenter: parent.horizontalCenter
                Column{
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    UText{
                        text: '<b>Nombre</b>'
                    }
                    UTextInput{
                        id: tiNombre
                        label: ''
                        width:r.width-app.fs
                    }
                }
                Column{
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    UText{
                        text: '<b>Fecha de Nacimiento</b>'
                    }
                    Row{
                        spacing: app.fs
                        UTextInput{
                            id: tiDia
                            label: 'Día:'
                            width:app.fs*6//+diffWidth
                        }
                        UTextInput{
                            id: tiMes
                            label: 'Mes:'
                            width:app.fs*6//+diffWidth
                        }
                        UTextInput{
                            id: tiAnio
                            label: 'Año:'
                            width:app.fs*6//+diffWidth
                        }
                    }
                }
                Column{
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    UText{
                        text: '<b>Hora de Nacimiento</b>'
                    }
                    Row{
                        spacing: app.fs
                        UTextInput{
                            id: tiHora
                            label: 'Hora:'
                            width:app.fs*6//+diffWidth
                        }
                        UTextInput{
                            id: tiMinutos
                            label: 'Mes:'
                            width:app.fs*6//+diffWidth
                        }
                    }
                }
                Column{
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    UText{
                        text: '<b>Lugar de Nacimiento</b>'
                    }
                    UTextInput{
                        id: tiCiudad
                        label: ''
                        width:r.width-app.fs
                        onSeted: getCoords(text)
                    }
                    UText{
                        id: statusLugar
                        font.pixelSize: app.fs*0.5
                        text: 'Ingresar ciudad'
                    }
                    UComboBox{
                        id: uCbCiudades
                        width: r.width-app.fs
                        visible: false
                        z: statusLugar.z+100
                        onCurrentIndexChanged: {
                            if(currentIndex!==0){
                                tiCiudad.text=currentText
                                getCoords(currentText)
                                visible=false
                            }
                        }
                    }
                }
                Row{
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    BotonUX{
                        id: botEjemplo
                        text: 'Ejemplo'
                        onClicked: {
                            tiNombre.text='Ricardo'
                            tiDia.text='20'
                            tiMes.text='06'
                            tiAnio.text='1975'
                            tiHora.text='23'
                            tiMinutos.text='00'
                            tiCiudad.text='Malargue'
                            getCoords(tiCiudad.text)
                        }
                    }
                    BotonUX{
                        id: botEnviar
                        text: 'Crear'
                        visible: tiNombre.text!==''&&tiDia.text!==''&&tiMes.text!==''&&tiAnio.text!==''&&tiHora.text!==''&&tiMinutos.text!==''&&r.lon!==''&&r.lat!==''
                        onClicked: {
                            getJson()
                        }
                    }
                }
            }
        }
    }
    XCnView{id: xCnView;visible: false}
    Component.onCompleted: {
//        let d0=unik.getFile('resources/codes')
//        let d1=d0.split('\n')
//        for(var i=0;i<d1.length;i++){
//            let d2=d1[i].split(',')
//            r.arrayCodesNames.push(d2[0])
//            r.arrayCodes.push(d2[1])
//        }
//        uCbPais.model=r.arrayCodesNames
    }
    function getCoords(text){
        let md=["Seleccionar Ciudad"]
        r.lon=''
        r.lat=''
        var req = new XMLHttpRequest();
        req.open('GET', 'https://www.geodatos.net/coordenadas/buscar?q='+text.replace(/ /g, '+')+'', true);
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                if(req.status === 200){
                    let m0= req.responseText.split('<div class="panel-body">')
                    for(let i=0;i<m0.length;i++){
                        let d0 = (''+m0[i])
                        //console.log('---------------------------------div'+i+': '+m0[i]+'-------------------\n\n\n')
                        if(d0.indexOf('Coordenadas decimales')>=0){
                            let m1=m0[i].split('<strong>')
                            if(m1.length>1){
                                let m2=m1[1].split('</strong>')
                                let m3=m2[0].split(', ')
                                if(m3.length>0){
                                    r.lon=m3[1]
                                    r.lat=m3[0]
                                    statusLugar.text='Coordenadas: lon: '+r.lon+' lat: '+r.lat
                                }
                                //console.log('Coordenadas: '+m2[0])
                                uCbCiudades.currentIndex=0
                            }
                            break
                        }
                        if(d0.indexOf('No se encontraron resultados')>=0){
                            let m1=m0[i].split('Lugares similares:')
                            if(m1.length>1){
                                statusLugar.text='Opciones: '
                                //console.log('Opciones: '+m1[1])
                                let m2=m1[1].split('<li ')
                                for(let i2=0;i2<m2.length;i2++){
                                    let m3=m2[i2].split('</span></a>')
                                    let m4=m3[0].split('>')
                                    let data=text+' '+(m4[m4.length-1]).replace(/,/g, ' ')
                                    md.push(data)
                                    statusLugar.text='Seleccionar una ciudad'
                                }
                            }
                            break
                        }
                    }
                    uCbCiudades.model=md
                    uCbCiudades.visible=md.length>1
                }else{
                    logView.showLog("Error loading page\n");
                }
            }
        };
        req.send(null);
    }
    function getJson(){
        let url='nom='+tiNombre.text.replace(/ /g, '_')+'&d='+tiDia.text+'&m='+tiMes.text+'&a='+tiAnio.text+'&h='+tiHora.text+'&min='+tiMinutos.text+'&lon='+r.lon+'&lat='+r.lat+'&loc='+tiCiudad.text.replace(/ /g, '_')
        console.log('Url: '+url)
        var req = new XMLHttpRequest();
        req.open('GET', r.serverUrl+':'+r.portRequest+'/cn/get/?'+url, true);
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                if(req.status === 200){
                    if(req.responseText.indexOf('file')>=0&&req.responseText.replace(/_/g, ' ').indexOf(tiNombre.text)>=0){
                        let obj=JSON.parse(req.responseText)
                        getJsonData(obj.file)
                    }
                }else{
                    logView.showLog("Error loading page\n");
                }
            }
        };
        req.send(null);
    }
    function getJsonData(file){
        let url=r.serverUrl+':'+r.portFiles+'/bios-files/'+file+'.json'
        console.log('Get json data from '+url)
        var req = new XMLHttpRequest();
        req.open('GET', url, true);
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                if(req.status === 200){
                    xCnView.visible=true
                    xCnView.xcn.setJson(req.responseText)
                    //logView.showLog(req.responseText)
                }else{
                    logView.showLog("Error loading page\n");
                }
            }
        };
        req.send(null);
    }
}
