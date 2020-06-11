import QtQuick 2.12
import QtQuick.Controls 2.12
import "qrc:/"

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    objectName: 'xgetcarta'
    property int cNumSigno: -1
    property int cGradoLuna: -1
    property string cSignoLuna: ''

    property string serverUrl: app.serverUrl
    property int portRequest: app.portRequest
    property int portFiles: app.portFiles
    property string lon: ''
    property string lat: ''

    property int mod: 0

    onVisibleChanged: {
        r.focus=visible
        if(visible){
            getTransNow()
        }
    }
    MouseArea{
        anchors.fill: r
    }
    Flickable{
        width: r.width
        height: r.height
        contentWidth: width
        contentHeight: col.height//+app.fs*6
        Column{
            id: col
            spacing: app.fs*2
            anchors.horizontalCenter: parent.horizontalCenter
            Flow{
                id: flowGetCarta
                width:r.width-app.fs
                spacing: app.fs
                BotonUX{
                    text: 'Atras'
                    fontSize: Qt.platform.os==='android'?(app.rot?app.fs*0.5:app.fs):app.fs
                    onClicked: {
                        unik.speak('atras')
                        app.mod=-2
                        r.destroy(10)
                    }
                }
                BotonUX{
                    id: botSetMod
                    text: r.mod===0?'Cartas Disponibles':'Crear Carta'
                    fontSize: Qt.platform.os==='android'?(app.rot?app.fs*0.5:app.fs):app.fs
                    onClicked: {
                        r.mod=r.mod===0?1:0
                    }
                }
                BotonUX{
                    text: 'Ver'
                    visible: r.mod===1&&xCnListDisp.cFileName!==''
                    onClicked: {
                        xCnView.xcn.setJson(unik.getFile('./cns/'+xCnListDisp.cFileName))
                        xCnListDisp.cFileName=''
                        xCnView.visible=true
                        r.mod=0
                    }
                }
                BotonUX{
                    visible: r.mod===1&&xCnListDisp.cFileName!==''
                    text: 'Eliminar'
                    onClicked: {
                        unik.deleteFile('./cns/'+xCnListDisp.cFileName)
                        xCnListDisp.cFileName=''
                    }
                }
            }
            Column{
                visible: r.mod===0
                spacing: app.fs*2
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    width: xApp.width-app.fs*2
                    text: '<b>Crear Carta Natal</b><br />'//+app.serverUrl+':'+app.portRequest
                    color: app.c2
                    font.pixelSize: app.fs*1
                    anchors.horizontalCenter: parent.horizontalCenter
                }
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
                        KeyNavigation.tab: tiDia
                        regularExp: RegExpValidator{regExp:  /^([A-Za-zÁÉÍÓÚñáéíóúÑ0-9]+[\s])+([A-Za-zÁÉÍÓÚñáéíóúÑ0-9])/}
                        maximumLength: 50
                    }
                }
                Column{
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    UText{
                        text: '<b>Fecha de Nacimiento</b>'
                    }
                    Item{
                        width: rowFecha.width
                        height: tiDia.height
                        Row{
                            id: rowFecha
                            spacing: app.fs
                            UTextInput{
                                id: tiDia
                                label: 'Día:'
                                width:app.fs*6//+diffWidth
                                KeyNavigation.tab: tiMes
                                regularExp: RegExpValidator{regExp:  /^[0-9][0-9]/}
                                maximumLength: 2
                            }
                            UTextInput{
                                id: tiMes
                                label: 'Mes:'
                                width:app.fs*6//+diffWidth
                                KeyNavigation.tab: tiAnio
                                regularExp: RegExpValidator{regExp:  /^[0-9][0-9]/}
                                maximumLength: 2
                            }
                            UTextInput{
                                id: tiAnio
                                label: 'Año:'
                                width:app.fs*6//+diffWidth
                                KeyNavigation.tab: tiHora
                                regularExp: RegExpValidator{regExp:  /^[0-9][0-9]/}
                                maximumLength: 4
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                calendario.visible=true
                            }
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
                            KeyNavigation.tab: tiMinutos
                            regularExp: RegExpValidator{regExp:  /^([1-9])[0-9]/}
                        }
                        UTextInput{
                            id: tiMinutos
                            label: 'Mes:'
                            width:app.fs*6//+diffWidth
                            KeyNavigation.tab: tiCiudad
                            regularExp: RegExpValidator{regExp:  /^[0-9][0-9]/}
                            maximumLength: 2
                        }
                    }
                }
                Column{
                    spacing: app.fs*0.5
                    anchors.horizontalCenter: parent.horizontalCenter
                    UText{
                        text: '<b>Lugar de Nacimiento</b>'
                    }
                    UText{
                        text: 'Escribir Ciudad, Provincia o Región y País'
                        font.pixelSize: app.fs*0.5
                    }
                    UText{
                        text: 'Ejemplo: Rosario Santa Fe Argentina'
                        font.pixelSize: app.fs*0.5
                    }
                    Row{
                        spacing: app.fs*0.5
                        UTextInput{
                            id: tiCiudad
                            label: ''
                            width:r.width-app.fs-botSearch.width-app.fs*0.5
                            KeyNavigation.tab: botSearch
                            onSeted: getCoords(text)
                            anchors.verticalCenter: parent.horizontalCenter
                            onTextChanged: {
                                botSearch.enabled=true
                                statusLugar.text='Presionar Boton <b>Buscar</b>'
                                r.lat=''
                                r.lon=''
                            }
                        }
                        BotonUX{
                            id: botSearch
                            text: 'Buscar'
                            opacity: tiCiudad.text!==''?1.0:0.0
                            KeyNavigation.tab: botEnviar
                            anchors.verticalCenter: parent.horizontalCenter
                            onClicked: {
                                getCoords(tiCiudad.text)
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*2
                        UText{
                            id: statusLugar1
                            font.pixelSize: app.fs*0.5
                            text: ''
                        }
                        UText{
                            id: statusLugar
                            font.pixelSize: app.fs*0.5
                            text: 'Ingresar ciudad'
                        }
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
                        KeyNavigation.tab: tiNombre
                        onClicked: {
                            if(unikSettings.sound){
                                unik.speak('Creando carta natal. Un momento por favor. Espero unos segundos.')
                            }
                            enabled=false
                            getJson()
                        }
                    }
                }
            }
            XCnListDisp{
                id: xCnListDisp
                height: r.height-flowGetCarta.height-col.spacing-app.fs*2
                visible: r.mod===1
            }
        }
    }
    Item{
        anchors.horizontalCenter: parent.horizontalCenter
        width: app.isPhone?r.width:r.width*0.5
        height: app.isPhone?r.height*0.5:r.height
        UCalendar{
            id: calendario
            //visible: true
            onVisibleChanged: {
                xApp.focus=true
            }
            onSelected: {
                enterForm()
            }
        }
    }
    XCnView{id: xCnView;visible: false}
    HttpObject{
        onHttpResponse:{
            //logView.showLog('R1: '+r)
        }
        onHttpResponseError:{
            logView.showLog('El sistema de Mercurio no está disponible\nPara pedir soporte o conexción escribir a nextsigner@gmail.com')
        }
        Component.onCompleted: {
            getHttp(app.serverUrl+':'+app.portRequest+'/ping')
        }
    }
    Component.onCompleted: {
        tiNombre.focus=true
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
        let url=r.serverUrl+':'+r.portRequest+'/cn/get/?'+'nom='+tiNombre.text.replace(/ /g, '_')+'&d='+tiDia.text+'&m='+tiMes.text+'&a='+tiAnio.text+'&h='+tiHora.text+'&min='+tiMinutos.text+'&lon='+r.lon+'&lat='+r.lat+'&loc='+tiCiudad.text.replace(/ /g, '_')
        console.log('Url: '+url)
        var req = new XMLHttpRequest();
        req.open('GET', url, true);
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                //logView.showLog("Code 4\n");
                if(req.status === 200){
                    if(req.responseText.indexOf('file')>=0&&req.responseText.replace(/_/g, ' ').indexOf(tiNombre.text)>=0){
                        //logView.showLog("Code 200 4\n");
                        let obj=JSON.parse(req.responseText)
                        noFocus()
                        getJsonData(obj.file)
                    }else{
                        //logView.showLog("Error al cargar datos de la carta. Code 6\n");
                        //console.log('RES 100: '+req.responseText)
                    }
                }else{
                    botEnviar.enabled=true
                    logView.showLog("Error al cargar datos de la carta. Code 4\n");
                }
            }
        };
        req.send(null);
    }
    function getJsonData(file){
        let url=r.serverUrl+':'+r.portFiles+'/files/'+file+'.json'
        xCnView.currentImgUrl=r.serverUrl+':'+r.portFiles+'/files/'+file+'.png'
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
                    logView.showLog("Error al cargar los datos de la carta. Code 5\n");
                }
                botEnviar.enabled=true
            }
        };
        req.send(null);
    }
    function noFocus(){
        tiNombre.focus=false
        tiDia.focus=false
        tiMes.focus=false
        tiAnio.focus=false
        tiHora.focus=false
        tiMinutos.focus=false
    }
    function upForm(){
        var fecha = calendario.selectedDate;
        fecha.setDate(fecha.getDate() - 1);
        calendario.setTextInput=false
        calendario.selectedDate=fecha
    }
    function downForm(){
        var fecha = calendario.selectedDate;
        fecha.setDate(fecha.getDate() + 1);
        calendario.setTextInput=false
        calendario.selectedDate=fecha
    }
    function rightForm(){
        var fecha = calendario.selectedDate;
        fecha.setMonth(fecha.getMonth() + 1);
        calendario.setTextInput=false
        calendario.selectedDate=fecha
    }
    function leftForm(){
        var fecha = calendario.selectedDate;
        fecha.setMonth(fecha.getMonth() - 1);
        calendario.setTextInput=false
        calendario.selectedDate=fecha
    }
    function shiftRightForm(){
        var fecha = calendario.selectedDate;
        fecha.setYear(fecha.getFullYear() + 1);
        calendario.setTextInput=false
        calendario.selectedDate=fecha
    }
    function shiftLeftForm(){
        var fecha = calendario.selectedDate;
        fecha.setYear(fecha.getFullYear() - 1);
        calendario.setTextInput=false
        calendario.selectedDate=fecha
    }
    function enterForm(){
        if(calendario.visible){
            let d = calendario.selectedDate
            let dia=''+d.getDate()
            if(d.getDate()<10){
                dia='0'+dia
            }
            let mes=''+parseInt(d.getMonth()+1)
            if(parseInt(d.getMonth()+1)<10){
                mes='0'+mes
            }
            let an=''+d.getFullYear()
            let s=''+dia+'/'+mes+'/'+an
            tiDia.text=dia
            tiMes.text=mes
            tiAnio.text=an
            calendario.visible=false
            return
        }
        if(tiCiudad.focus){
            getCoords(tiCiudad.text)
            return
        }
    }
    function escForm(){
        if(calendario.visible){
            calendario.visible=false
            return
        }
        if(Qt.platform.os==='android'&&xCnView.mod===1){
            xCnView.mod=0
            return
        }
        if(Qt.platform.os==='android'&&xCnView.mod===0){
            xCnView.visible=false
            return
        }
        r.destroy(10)
        app.mod=-2
    }
}
