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
            Row{
                spacing: app.fs
                BotonUX{
                    text: 'Atras'
                    fontSize: app.rot?app.fs*0.5:app.fs
                    onClicked: {
                        app.mod=-1
                        unik.speak('atras')
                    }
                }
                BotonUX{
                    visible: cbAsc.currentIndex!==0
                    text: 'Detener Voz'
                    fontSize: app.rot?app.fs*0.5:app.fs
                    onClicked: {
                        unik.speak('Detenido.')
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
                width: xApp.width-app.fs*2
                text: '<b>Tránsito Lunar</b>'
                color: app.c2
                font.pixelSize: app.fs*2
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Column{
                spacing: app.fs*0.5
                anchors.horizontalCenter: parent.horizontalCenter
                Text{
                    width: xApp.width-app.fs*2
                    text: 'La Luna está en el signo número '+r.cNumSigno
                    color: app.c2
                    font.pixelSize: app.fs*2
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                ComboBox{
                    id: cbAsc
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
                            destinatario='persona con '+model[currentIndex]
                        }else{
                            destinatario=model[currentIndex]
                        }
                        pp='Actualmente '+destinatario
                        let gradoActualDeLuna = r.cGradoLuna
                        if(gradoActualDeLuna<12){
                            pf+='<br /><br />La persona va a estar así hoy y mañana.'
                        }else if(gradoActualDeLuna>=12&&gradoActualDeLuna<24){
                            pf+='La persona va a estar así hoy y mañana cambia a la casa número '+parseInt(numAsc+1)+' en el signo '+app.signos[r.cNumSigno]
                        }else{
                            pf+='La persona va a estar así hoy'
                        }
                        resTransLunar.text=pp+' tiene la Luna en tránsito en el grado '+gradoActualDeLuna+' de la casa número '+numCasa+' en el signo de '+app.signos[r.cNumSigno - 1]
                        resTransLunar.text+='<br /><br />'+getAsunto(numCasa, destinatario)
                        resTransLunar.text+=pf+'<br /><br />'
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
    }
    function speak(text){
        let s = ''+text.replace(/<br \/>/g, '')
        unik.speak(s)
    }
    function getNumCasa(asc, currentSigno){
        let ci = app.signos.indexOf(asc)
        let numCasa = 12 -  ci  + currentSigno
        //console.log('ci0::::::::::::::'+asc)
        //console.log('ci::::::::::::::'+ci)
        return numCasa
    }
    function getAsunto(casa, destinatario){
        let ret=''
        if(casa===1){
            ret='El corazón y los sentimientos de '+destinatario+' van a estar conectados a la vitalidad, a la fortaleza en el momento de un inicio de algo que sucede a su alrrededor mientras ocurre este tránsito. Posiblemente el corazón de '+destinatario+' siente que algo comienza y se conecta con fuerzas y sentimientos de la infancia, ansiedad, impaciencia, nervios por el inicio de un evento o acción que se va a iniciar. Las emociones impulsan a la persona a juntar fuerzas.'
        }
        if(casa===2){
            ret='El corazón y los sentimientos de '+destinatario+' van a estar enfocados en asuntos relacionados con la administración de sus valores, objetos, dinero o recursos. Estará pensando en el cuidado con los excesos en los gastos, en las deudas, las fuentes de ingresos, las propiedades y el cierre de sus cuentas y balances a los fines de procurar no tener problemas de falta de recursos.'
        }
        if(casa===3){
            ret='El corazón y los sentimientos de '+destinatario+' van a estar conectados con el entorno cercano. Va a estar interesado en comunicarse, prestar atención a sus vínculos más próximos, esas personas que considera de su grupo. <br /><br />'+capital_letter(destinatario)+' va a tener un impulso y una predisposición en escuchar, conversar o decir cosas a esas personas que lo rodean. Si no es escuchada, si es ignorada o no logra comunicarse con su entorno, posiblemente se sienta triste, enojada o desanimada. Si logra conectar con su entorno cercano a travez de una comunicación fluida, estará mejor de ánimo.'
        }
        if(casa===4){
            ret='El corazón y los sentimientos de '+destinatario+' van a estar conectados con asuntos, emociones y recuerdos relacionados con la familia de donde uno proviene, los hermanos, los padres, abuelos, primos o todo aquello que le haga recordar sus raíces. '+capital_letter(destinatario)+' talvez se sienta algo nostálgica, un poco melancólica o un poco pensativa en el pasado. <br /><br />Si la infancia de '+destinatario+' no ha sido buena es posible que los recuerdos estén afectando su parte mental inconciente y su mal humor se manifieste sin saber a qué razón se debe esa reacción. <br /><br />Si la persona ha tenido una infancia algo feliz o con una felicidad plena, es posible que se sienta con una energía juvenil, con ganas de jugar, de comer comídas o alimentos sabrosos que le recuerden el aroma y el sabor que había en su hogar en sus épocas de infancia. '
        }
        if(casa===5){
            ret='El corazón y los sentimientos de '+destinatario+' van a estar vibrando con la energía necesaria para iniciar o estar a pleno en actividades relacionadas con la creatividad, la diversión, la alegría. '+capital_letter(destinatario)+' estará interesada en hacer cosas que logren llamar la atención de los demás. Buscará el reconocimiento de los demás. Tratará de figurar, de decir -Acá estoy, mirenme-, intentará no pasar desapercibido. Lo que su nucleo emocional está demandando es reforzar un poco la propia identidad, el amor propio y el orgullo personal.'
        }
        if(casa===6){
            ret='El corazón y los sentimientos de '+destinatario+' van a estar conectados con las rutinas, tareas y actividades que realiza a menudo, que hace muy seguido, con cierta frecuencia.'
        }
        if(casa===7){
            ret='El corazón y los sentimientos de '+destinatario+' van a estar conectados con los asuntos relacionados con los compromisos, los acuerdos convivenciales o matrimoniales, con los contratos o sociedades. Estará buscando en su interior y en sus acciones el mayor equilibrio posible entre lo que desea hacer y lo que puede hacer, entre sus desiciones y lo bueno o malo de dichas desiciones. Estará pensando y analizando las consecuencias de sus acciones. Evaluará si está bien o mal y en base a ello intentará buscar el equilibrio deseado.'
        }
        if(casa===8){
            ret='El corazón y los sentimientos de '+destinatario+' van a estar removidos por una influencia transformadora relacionada con los peligros, la muerte, el final y la necesidad de renovación de los ciclos naturales de su cuerpo, mente y alma. Estará procesando el modo de percepción de su existencia a traves de los sentidos, del cuerpo, la piel y principalmente el sexo. Estará analizando asuntos relacionados con herencias, bienes ajenos, impuestos, bienes o recursos que otros nos delegan para administrar.'
        }
        if(casa===9){
            ret='El corazón y los sentimientos de '+destinatario+' van a estar enfocados en los viajes largos, el extranjero o los lugares lejanos. La necesidad de ampliar los conocimientos y de expandirse mucho más allá de la posición y situación actual.'
        }
        if(casa===10){
            ret='El corazón y los sentimientos de '+destinatario+' van a estar enfocados en los asuntos relacionados con la vocación o la vocación en el trabajo. Estará buscando sostener y completar todo lo necesario para afirmar cada vez más el status social para así lograr el reconocimiento social.'
        }
        if(casa===11){
            ret='El corazón y los sentimientos de '+destinatario+' van a estar conectados con las amistades, los grupos o asociaciones a las que pertenezca o quiera pertenecer. Estará moviendose para lograr establecer el contacto y la interacción que le posibilita acceder a una vida social, creando vínculos, charlando, organizando y concurriendo junto a grupos de personas para fusionar su individualidad entre otras personas para vivir nuevas experiencias.'
        }
        if(casa===12){
            ret='El corazón y los sentimientos de '+destinatario+' van a enfocarse en los asuntos relacionados con las enfermedades crónicas, los encierros propios o ajenos, los retiros prolongados, los manicomios, los enemigos o los ladrones. Estará analizando cuales son sus potencialidades y debilidades ante cualquiera de esos males o dificultades.'
        }
        return ret
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
                        logView.showLog('XXX'+g1[0]+'XXX')
                        r.cGradoLuna=parseInt(g1[0])
                        //repTrans.arrayGrados.push(' está a °'+g1[0]+ ' de ')

                        //Signo
                        let s0=m1[4].split('alt=\"')
                        let s1=s0[1].split('\"')
                        let s2=''+s1[0]
                        //repTrans.arraySignos.push(s2)
                        if(s2.indexOf('Aries')>=0){
                            cNumSigno=1
                        }else if(s2.indexOf('Tauro')>=0){
                            cNumSigno=2
                        }else{
                            r.cNumSigno=-2
                        }

                        //logView.showLog(s0)
                    }
                    //repTrans.model= ['Sol', 'Luna', 'Mercurio', 'Venus', 'Marte', 'Jupiter', 'Saturno', 'Urano', 'Neptuno', 'Pluton', 'Nodo Norte', 'Quirón']
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
