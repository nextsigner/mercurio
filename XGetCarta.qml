import QtQuick 2.12
import QtQuick.Controls 2.12
import "func.js" as JS
import "qrc:/"

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    objectName: 'xgetcarta'

    //Auto Launch
    property bool autoLaunch: false
    property string alNom
    property string alFecha
    property string alHora
    property string alLugar
    property string alGMT

    property alias xcnview: xCnView
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
        contentHeight: r.mod===0?col.height+app.fs*6:xCnListDisp.height
        Column{
            id: col
            spacing: app.fs*2
            anchors.horizontalCenter: parent.horizontalCenter
            visible: r.mod===0
            Flow{
                id: flowGetCarta
                width:r.width-app.fs
                spacing: app.fs*0.5
                BotonUX{
                    text: 'Atras'
                    fontSize: Qt.platform.os==='android'?(app.rot?app.fs*0.5:app.fs):app.fs
                    onClicked: {
                        JS.speak('atras')
                        app.mod=-2
                        r.destroy(10)
                    }
                }
                //                BotonUX{
                //                    id: botSetMod
                //                    text: r.mod===0?'Cartas Disponibles':'Crear Carta'
                //                    fontSize: Qt.platform.os==='android'?(app.rot?app.fs*0.5:app.fs):app.fs
                //                    onClicked: {
                //                        r.mod=r.mod===0?1:0
                //                    }
                //                }
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
                spacing: app.fs*2
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    width: xApp.width-app.fs*2
                    text: '<b>Crear Carta Natal</b><br />'
                    color: app.c2
                    font.pixelSize: app.fs*1
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Column{
                    spacing: app.fs*0.25
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
                    spacing: app.fs*0.25
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
                                enabled: false
                                label: 'Día:'
                                width:app.fs*6//+diffWidth
                                anchors.verticalCenter: parent.verticalCenter
                                KeyNavigation.tab: tiMes
                                regularExp: RegExpValidator{regExp:  /^[0-9][0-9]/}
                                maximumLength: 2
                            }
                            UTextInput{
                                id: tiMes
                                enabled: false
                                label: 'Mes:'
                                width:app.fs*6//+diffWidth
                                anchors.verticalCenter: parent.verticalCenter
                                KeyNavigation.tab: tiAnio
                                regularExp: RegExpValidator{regExp:  /^[0-9][0-9]/}
                                maximumLength: 2
                            }
                            UTextInput{
                                id: tiAnio
                                enabled: false
                                label: 'Año:'
                                width:app.fs*6//+diffWidth
                                anchors.verticalCenter: parent.verticalCenter
                                KeyNavigation.tab: tiHora
                                regularExp: RegExpValidator{regExp:  /^[0-9][0-9]/}
                                maximumLength: 4
                            }
                            BotonUX{
                                text: 'Elegir Fecha'
                                anchors.verticalCenter: parent.verticalCenter
                                onClicked: {
                                    calendario.visible=true
                                }
                            }
                        }
                    }
                }
                Column{
                    spacing: app.fs*0.25
                    anchors.horizontalCenter: parent.horizontalCenter
                    UText{
                        text: '<b>Hora de Nacimiento</b> Formato 24hs.'
                    }
                    Row{
                        spacing: app.fs
                        UTextInput{
                            id: tiHora
                            label: 'Hora:'
                            text: '00'
                            property int uvv: text
                            width:app.fs*6//+diffWidth
                            KeyNavigation.tab: tiMinutos
                            regularExp: RegExpValidator{regExp:  /^([1-9])[0-9]/}
                            onTextChanged: {
                                if(parseInt(text)>24){
                                    text='24'
                                }
                            }
                        }
                        UTextInput{
                            id: tiMinutos
                            label: 'Minutos:'
                            text: '00'
                            property int uvv: text
                            width:app.fs*7//+diffWidth
                            KeyNavigation.tab: tiCiudad
                            regularExp: RegExpValidator{regExp:  /^[0-9][0-9]/}
                            maximumLength: 2
                            onTextChanged: {
                                if(parseInt(text)>60){
                                    text='60'
                                }
                            }
                        }
                    }
                }
                Column{
                    spacing: app.fs*0.25
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
                            anchors.verticalCenter: parent.horizontalCenter
                            onTextChanged: {
                                botSearch.enabled=true
                                statusLugar.text='Presionar Boton <b>Buscar</b>'
                                botCopyCoords.visible=false
                                r.lat=''
                                r.lon=''
                            }
                        }
                        BotonUX{
                            id: botSearch
                            text: 'Buscar'
                            opacity: tiCiudad.text!==''?1.0:0.0
                            KeyNavigation.tab: botCopyCoords
                            anchors.verticalCenter: parent.horizontalCenter
                            onClicked: {
                                getCoords(tiCiudad.text)
                            }
                        }
                    }
                    Row{
                        spacing: app.fs*2
                        //height: botCopyCoords.height
                        UText{
                            id: statusLugar1
                            font.pixelSize: app.fs*0.5
                            text: ''
                            anchors.verticalCenter: parent.horizontalCenter
                        }
                        UText{
                            id: statusLugar
                            font.pixelSize: app.fs
                            text: 'Ingresar ciudad'
                            anchors.verticalCenter: parent.horizontalCenter
                        }
                        BotonUX{
                            id: botCopyCoords
                            text: 'Copiar Coordenadas'
                            visible: false
                            KeyNavigation.tab: botEnviar
                            anchors.verticalCenter: parent.horizontalCenter
                            property string coords: ''
                            onClicked: {
                                clipboard.setText(coords)
                            }
                        }
                    }
                    Row{
                        spacing: app.fs
                        UText{
                            font.pixelSize: app.fs
                            text: 'Selectionar GMT:'
                        }
                        UComboBox{
                            id: uCbGMT
                            width: app.fs*6
                            model: ['-12','-11','-10','-9', '-8', '-7', '-6', '-5', '-4', '-3', '-2', '-1', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']
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
                            uCbGMT.currentIndex=9
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
                    BotonUX{
                        id: botLanzar
                        text: 'Lanzar'
                        visible: tiNombre.text!==''&&tiDia.text!==''&&tiMes.text!==''&&tiAnio.text!==''&&tiHora.text!==''&&tiMinutos.text!==''&&r.lon!==''&&r.lat!==''
                        KeyNavigation.tab: tiNombre
                        onClicked: {
                            let cmd=r.serverUrl+':'+r.portRequest+'/cn/get/?'+'nom='+tiNombre.text.replace(/ /g, '_')+'&d='+tiDia.text+'&m='+tiMes.text+'&a='+tiAnio.text+'&h='+tiHora.text+'&min='+tiMinutos.text+'&lon='+r.lon+'&lat='+r.lat+'&loc='+tiCiudad.text.replace(/ /g, '_')
                            let d=new Date(Date.now())
                            let ms=d.getTime()
                            let cmd2='wine /home/ns/zodiacserver/bin/zodiac_server.exe '+tiNombre.text.replace(/ /g, '_')+' '+tiAnio.text+' '+tiMes.text+' '+tiDia.text+' '+tiHora.text+' '+tiMinutos.text+' '+parseInt(uCbGMT.currentText)+' '+r.lat+' '+r.lon+' '+tiCiudad.text.replace(/ /g, '_')+' /home/ns/temp-screenshots/'+ms+'.json '+ms+' 3 "/home/ns/temp-screenshots/cap_'+ms+'.png" 2560x1440 2560x1440'
                            unik.run(cmd2)
                            /*if(unikSettings.sound){
                                unik.speak('Creando carta natal. Un momento por favor. Espero unos segundos.')
                            }
                            enabled=false
                            getJson()*/
                        }
                    }
                }
            }
        }
        //        XCnListDisp{
        //            id: xCnListDisp
        //            width: r.width
        //            height: r.height//-flowGetCarta.height-col.spacing-app.fs*2
        //            visible: r.mod===1
        //            container: r
        //        }
    }
    Item{
        anchors.horizontalCenter: parent.horizontalCenter
        width: app.isPhone?r.width:r.width*0.5
        height: app.isPhone?r.height*0.75:r.height
        UCalendar{
            id: calendario
            onVisibleChanged: {
                xApp.focus=true
            }
            onSelected: {
                enterForm()
            }
        }
    }
    XCnView{id: xCnView;visible: false}
    //    UGeoLocCoordsSearch{
    //        //url: 'https://www.google.com/maps?q=laferrere'
    //        url: 'https://www.google.com/maps?q=lsaf ñaslfkñalfdkj'
    //        onCoordsLoaded: {
    //            console.log('lon: '+longitude+' lat: '+latitude+' alt: '+altitude)
    //        }
    //    }
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
    XLoadingCoords{id: xLoadingCoords}
    Component.onCompleted: {
        if(r.autoLaunch){
            //unik.speak('Lanzando Zodiac.')
            getCoords(r.alLugar)
        }
        tiNombre.focus=true
    }
    function runAutoLaunch(lon, lat){
        let mFecha=r.alFecha.split('/')
        let mHora=r.alHora.split(':')
        let d=new Date(Date.now())
        let ms=d.getTime()
        let cmd2='wine /home/ns/zodiacserver/bin/zodiac_server.exe '+r.alNom.replace(/ /g, '_')+' '+mFecha[2]+' '+mFecha[1]+' '+mFecha[0]+' '+mHora[0]+' '+mHora[1]+' '+r.alGMT+' '+lat+' '+lon+' '+r.alLugar.replace(/ /g, '_')+' /home/ns/temp-screenshots/'+r.alNom.replace(/ /g, '_')+'.json '+ms+' 3 "/home/ns/temp-screenshots/cap_'+r.alNom.replace(/ /g, '_')+'.png" 2560x1440 2560x1440'
        unik.run(cmd2)
        Qt.quit()
    }
    function getCoordsByUrl(url){
        let md=["Seleccionar Ciudad"]
        r.lon=''
        r.lat=''
        var req = new XMLHttpRequest();
        req.open('GET', url, true);
        req.onreadystatechange = function (aEvt) {
            if (req.readyState === 4) {
                if(req.status === 200){
                    let rt=req.responseText
                    //let m0= rt.split('<div class="flex justify-center text-center">')
                    //let d0 = (''+m0[1])
                    //let m1=m0[1].split('<ul')
                    let m10=rt.split('<h1>Coordenadas')
                    //console.log('---------------------------------rt:::'+rt+'-------------------\n\n\n')
                    //console.log('RU: '+rt)
                    if(m10.length>1){
                        console.log('m10::::'+m10[1])
                        let m11=m10[1].split('latitud ')
                        let m12=m10[1].split('longitud ')
                        //if(m11.length>1){
                        let m111=m11[1].split(' ')
                        let m222=m12[1].split('. ')
                        //let m3=m2[0].split(', ')
                        //if(m3.length>0){
                        r.lon=parseFloat(m222[0])
                        r.lat=parseFloat(m111[0])
                        statusLugar.text='Coordenadas: lon: '+r.lon+' lat: '+r.lat
                        botCopyCoords.coords='lon: '+r.lon+' lat: '+r.lat
                        botCopyCoords.visible=true
                        //}
                        //console.log('Coordenadas: '+m2[0])
                        //uCbCiudades.currentIndex=0
                        //}
                        //uCbCiudades.model=md
                        //uCbCiudades.visible=md.length>1
                        //return
                    }
                }else{
                    logView.showLog("Error loading page\n");
                }
            }
        };
        req.send(null);
    }

    function getCoords(text){
        xLoadingCoords.ciudad=text
        xLoadingCoords.visible=true
        let md=["Seleccionar Ciudad"]
        r.lon=''
        r.lat=''
        let c=''
            +'import QtQuick 2.0'+'\n'
            +'UGeoLocCoordsSearch{'+'\n'
            +'  url: \'https://www.google.com/maps?q='+text.replace(/ /g, '%20')+'\''+'\n'
            +'  onCoordsLoaded: {'+'\n'
        //+'      console.log(\'Url final: \'+url)'+'\n'
        //+'      console.log(\'lon: \'+longitude+\' lat: \'+latitude+\' alt: \'+altitude)'+'\n'
            +'          r.lon=parseFloat(longitude)'+'\n'
            +'          r.lat=parseFloat(latitude)'+'\n'
            +'          if(r.autoLaunch){'+'\n'
            +'                runAutoLaunch(r.lon, r.lat)'+'\n'
            +'                return'+'\n'
            +'           }'+'\n'
            +'          statusLugar.text=\'Coordenadas: lon: \'+r.lon+\' lat: \'+r.lat'+'\n'
            +'          botCopyCoords.coords=\'lon: \'+r.lon+\' lat:\'+r.lat\n'
            +'          botCopyCoords.visible=true\n'
            +'          xLoadingCoords.visible=false'+'\n'
            +'  }'+'\n'
            +'}'+'\n'
        let comp=Qt.createQmlObject(c, r, 'getCoords')
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
        if(tiCiudad.text!==''){
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
/*
<div class="flex justify-center text-center">
                <ul>
                                            <li class="mb-1 flex items-center f16">
                            <span class="flag ar mr-2"></span>
                            <a class="blue" href="https://www.geodatos.net/coordenadas/argentina/malargue">Malargüe, Mendoza, Argentina</a>
                        </li>
                                            <li class="mb-1 flex items-center f16">
                            <span class="flag ir mr-2"></span>
                            <a class="blue" href="https://www.geodatos.net/coordenadas/iran/malard">Malārd, Tehrān, Irán</a>
                        </li>
                                            <li class="mb-1 flex items-center f16">
                            <span class="flag es mr-2"></span>
                            <a class="blue" href="https://www.geodatos.net/coordenadas/espana/mala-canarias">Mala, Canarias, España</a>
                        </li>
                                            <li class="mb-1 flex items-center f16">
                            <span class="flag pe mr-2"></span>
                            <a class="blue" href="https://www.geodatos.net/coordenadas/peru/mala">Mala, Lima region, Perú</a>
                        </li>
                                            <li class="mb-1 flex items-center f16">
                            <span class="flag cn mr-2"></span>
                            <a class="blue" href="https://www.geodatos.net/coordenadas/china/mala-chongqing">Mala, Chongqing, China</a>
                        </li>
                                            <li class="mb-1 flex items-center f16">
                            <span class="flag se mr-2"></span>
                            <a class="blue" href="https://www.geodatos.net/coordenadas/suecia/mala-vasterbotten">Malå, Västerbotten, Suecia</a>
                        </li>
                                            <li class="mb-1 flex items-center f16">
                            <span class="flag by mr-2"></span>
                            <a class="blue" href="https://www.geodatos.net/coordenadas/bielorrusia/malaryta">Malaryta, Brest, Bielorrusia</a>
                        </li>
                                            <li class="mb-1 flex items-center f16">
                            <span class="flag ca mr-2"></span>
                            <a class="blue" href="https://www.geodatos.net/coordenadas/canada/malartic">Malartic, Quebec, Canadá</a>
                        </li>
                                            <li class="mb-1 flex items-center f16">
                            <span class="flag fi mr-2"></span>
                            <a class="blue" href="https://www.geodatos.net/coordenadas/finlandia/malax">Malax, Ostrobothnia, Finlandia</a>
                        </li>
                                            <li class="mb-1 flex items-center f16">
                            <span class="flag au mr-2"></span>
                            <a class="blue" href="https://www.geodatos.net/coordenadas/australia/malak">Malak, Northern Territory, Australia</a>
                        </li>
                                            <li class="mb-1 flex items-center f16">
                            <span class="flag mw mr-2"></span>
                            <a class="blue" href="https://www.geodatos.net/coordenadas/malaui">Malaui</a>
                        </li>
                                            <li class="mb-1 flex items-center f16">
                            <span class="flag my mr-2"></span>
                            <a class="blue" href="https://www.geodatos.net/coordenadas/malasia">Malasia</a>
                        </li>
                                    </ul>
            </div>
*/
