
import QtQuick 2.0
import QtGraphicalEffects 1.0
import "func.js" as JS

Rectangle {
    id: r
    width: app.fs*30
    height: width
    color: app.c1
    antialiasing: true
    property int fs: r.width*0.05
    property var arrayCasas1: ['Asc', 'II', 'III', 'IV', 'V', 'VI']
    property var arrayCasas2: ['VII', 'VII', 'IX', 'X', 'XI', 'XII']
    property string borderColor: app.c2
    property var arrayElementsColors: ['#E7B70B', 'brown', '#16E9F6', '#118CC8']
    property int sigRot: 0
    property int ascSignIndex: -1
    property int ascDegree: -1
    property int ascMinutes: -1
    property color axisColor: 'red'

    property string cAscName: '?'

    property int angleRotH1: 0
    property int angleRotH2: 0
    property int angleRotH3: 0
    property int angleRotH4: 0
    property int angleRotH5: 0
    property int angleRotH6: 0

    property int sh1:-1
    property int sh2:-1
    property int sh3:-1
    property int sh4:-1
    property int sh5:-1
    property int sh6:-1

    property int ppx: 50
    property real zf: 0.5

    property var objSignsNames: ['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
    property var objSigns: [0,0,0,0,0,0,0,0,0,0,0,0]

    signal doubleClick
    signal posChanged(int px, int py)

    //    Item {
    //        anchors.fill: parent
    //        visible: false
    //        Repeater{
    //            model: r.arrayCasas1
    //            Item{
    //                width: r.width+r.fs
    //                height: 3
    //                anchors.centerIn: parent
    //                rotation: 0-index*30
    //                Rectangle{
    //                    width: parent.width-r.fs
    //                    height: 3
    //                    color: 'red'
    //                    anchors.centerIn: parent
    //                    antialiasing: true
    //                }
    //                Text{
    //                    text: index!==0?modelData:'Asc\n'+r.cAscName+'\n°'+r.ascDegree+' \''+r.ascMinutes
    //                    font.pixelSize: r.fs
    //                    color: 'white'
    //                    anchors.right: parent.left
    //                    //anchors.rightMargin: r.fs
    //                    anchors.verticalCenter: parent.verticalCenter
    //                    rotation: index*30
    //                    horizontalAlignment: index!==0?Text.AlignHCenter:Text.AlignRight
    //                }
    //                Text{
    //                    text: r.arrayCasas2[index]
    //                    font.pixelSize: r.fs
    //                    color: 'white'
    //                    anchors.left: parent.right
    //                    //anchors.rightMargin: r.fs
    //                    anchors.verticalCenter: parent.verticalCenter
    //                    rotation: index*30
    //                }
    //            }
    //        }
    //    }

    Rectangle{
        id: bg
        width: r.width-r.fs*2
        height: width
        radius: width*0.5
        color: 'transparent'
        border.width: 1
        border.color: r.borderColor
        anchors.centerIn: r
    }
    Item {
        id: xSig
        width: bg.width
        height: width
        anchors.centerIn: r
        rotation: r.sigRot
        antialiasing: true
        Repeater{
            id: rep
            model: 12
            Item{
                width: parent.width
                height: 3
                anchors.centerIn: parent
                rotation: 0-index*30
                antialiasing: true
                //clip: true
                property color c: index===0?'gray':'green'
                Repeater{
                    id: repG
                    model: 30
                    Rectangle{
                        id: xG
                        width: parent.width
                        height: index!==0?r.width*0.01:r.width*0.0075//r.fs*0.5
                        rotation: 0-index*1
                        color: 'transparent'//parent.c
                        antialiasing: true
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        Row{
                            anchors.centerIn: parent
                            Rectangle{
                                width: parent.parent.width*0.5
                                height: parent.parent.height
                                color: xG.parent.c
                            }
                            Rectangle{
                                width: parent.parent.width*0.5
                                height: parent.parent.height
                                color: 'transparent'
                            }
                        }
                    }
                    Component.onCompleted: {
                        if(index===0||index===4||index===8){
                            c=arrayElementsColors[0]
                        }
                        if(index===1||index===5||index===9){
                            c=arrayElementsColors[1]
                        }
                        if(index===2||index===6||index===10){
                            c=arrayElementsColors[2]
                        }
                        if(index===3||index===7||index===11){
                            c=arrayElementsColors[3]
                        }
                    }
                }
                Item {
                    width: parent.width
                    height: parent.height
                    rotation: -15
                    Image {
                        id: iconoSig
                        source: './resources/imgs/signos/'+index+'.png'
                        width: r.fs*1.5
                        height: width
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: r.fs*4
                        rotation: index*30+15-r.sigRot
                        visible: false
                        antialiasing: true
                    }
                    ColorOverlay{
                        source: iconoSig
                        anchors.fill: iconoSig
                        color: 'red'
                        rotation: iconoSig.rotation
                        antialiasing: true
                        Component.onCompleted: {
                            if(index===0||index===4||index===8){
                                color='black'
                            }
                            if(index===1||index===5||index===9){
                                color='white'
                            }
                            if(index===2||index===6||index===10){
                                color='black'
                            }
                            if(index===3||index===7||index===11){
                                color='black'
                            }
                        }
                    }
                }
            }
        }
    }
    Item {
        id: xHouses
        width: bg.width
        height: width
        anchors.centerIn: r
        rotation: r.sigRot
        antialiasing: true
        Repeater{
            id: repH
            model: 12
            Item{
                width: parent.width
                height: 3
                anchors.centerIn: parent
                rotation: 0-index*30
                antialiasing: true
                //clip: true
                property color c: index===0?'gray':'green'
                Rectangle{
                    id: axis
                    width: parent.width+r.fs*2
                    height: 2
                    color: 'red'
                    antialiasing: true
                    anchors.horizontalCenter: parent.horizontalCenter
                    Item{
                        id: cirH10
                        width: r.fs*0.5
                        height: width
                        anchors.right:  parent.right
                        anchors.rightMargin: 0-width*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        antialiasing: true
                        visible: false
                        Rectangle{
                            anchors.fill: parent
                            radius: width*0.5
                            color: app.c2
                            antialiasing: true
                        }
                    }
                    Item{
                        id: rectH1
                        width: r.fs*0.5
                        height: width
                        anchors.left: parent.left
                        anchors.leftMargin: 0-width*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        antialiasing: true
                        visible: false
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                tagHor.visible=true
                            }
                            onExited: tagHor.visible=false
                            onClicked: {
                                unik.speak('Ascendente '+r.cAscName+' en el grado '+r.ascDegree)
                            }
                        }
                        Rectangle{
                            rotation: 45
                            anchors.fill: parent
                            color: app.c2
                            antialiasing: true
                        }
                        Rectangle{
                            id: tagHor
                            visible: false
                            width: 1
                            height: r.height*0.5
                            color: app.c2
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                            Rectangle{
                                width: r.fs*5
                                height: 1
                                color: app.c2
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.top
                                Text{
                                    text: 'Horizonte'
                                    font.pixelSize: r.fs
                                    color: app.c2
                                    anchors.bottom: parent.top
                                }
                            }
                        }
                    }
                    Text{
                        id: l1
                        text: index!==0?r.arrayCasas1[index]:'Asc\n'+r.cAscName+'\n°'+r.ascDegree+' \''+r.ascMinutes
                        font.pixelSize: r.fs
                        color: app.c2
                        anchors.right: parent.left
                        anchors.rightMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: index!==0?Text.AlignHCenter:Text.AlignRight
                    }
                    Text{
                        id: l2
                        text: r.arrayCasas2[index]
                        font.pixelSize: r.fs
                        color: app.c2
                        anchors.left: parent.right
                        anchors.leftMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        rotation: index*30
                    }
                    Timer{
                        running: true
                        repeat: true
                        interval: 3000
                        onTriggered: axis.setRot()
                    }
                    function setRot() {
                        //console.log('r.ascSignIndex: '+r.ascSignIndex+' index: '+index+' r.sh4: '+r.sh4)
                        if(index===r.sh1){
                            //axis.color='#88ff33'
                            //l1.text='II'
                            rectH1.visible=true
                            l2.rotation=30-r.angleRotH1
                            axis.rotation=0-r.angleRotH1
                        }else if(index===r.sh2){
                            //axis.color='#ff3388'
                            l1.text='II'
                            l1.rotation=60-r.angleRotH2
                            l2.text='VIII'
                            l2.rotation=60-r.angleRotH2
                            axis.rotation=0-r.angleRotH2
                        }else if(index===r.sh3){
                            //axis.color='#88ff33'
                            l1.text='III'
                            l1.rotation=90-r.angleRotH3
                            l2.text='IX'
                            l2.rotation=90-r.angleRotH3
                            axis.rotation=0-r.angleRotH3
                        }else if(index===r.sh4){
                            //axis.color='#ff8833'
                            cirH10.visible=true
                            l1.text='IV'
                            l1.rotation=90+r.angleRotH4
                            l2.text='X'
                            l2.rotation=90+r.angleRotH4
                            axis.rotation=0-r.angleRotH4
                        }else if(index===r.sh5){
                            //axis.color='#88dd33'
                            l1.text='V'
                            l1.rotation=120+r.angleRotH5
                            l2.text='XI'
                            l2.rotation=120+r.angleRotH5
                            axis.rotation=0-r.angleRotH5
                        }else if(index===r.sh6){
                            //axis.color='#99ff22'
                            l1.text='VI'
                            l1.rotation=150+r.angleRotH6
                            l2.text='XII'
                            l2.rotation=150+r.angleRotH6
                            axis.rotation=0-r.angleRotH6
                        }else{
                            axis.visible=false
                        }
                        //                        if(index+r.ascSignIndex===0){
                        //                            axis.color='#ff8833'
                        //                            axis.rotation=0-r.angleRotH1
                        //                            //axis.visible=false
                        //                        }else if(index+r.ascSignIndex===1){
                        //                            axis.color='#88ff33'
                        //                            axis.rotation=0-r.angleRotH2
                        //                            //axis.visible=false
                        //                        }else if(index+r.ascSignIndex===2){
                        //                            axis.color='yellow'
                        //                            axis.rotation=0-r.angleRotH3
                        //                            //axis.visible=false
                        //                        }else if(index+r.ascSignIndex===3){
                        //                            axis.color='#ff9922'
                        //                            axis.rotation=0-r.angleRotH4
                        //                        }/*else if(index+r.ascSignIndex===4){
                        //                            axis.color='green'
                        //                            axis.rotation=0-r.angleRotH5
                        //                        }*/else{
                        //                            axis.visible=false
                        //                        }
                    }
                }
            }
        }
    }
    Rectangle{
        id: bg2
        width: r.width*0.2
        height: width
        radius: width*0.5
        //        border.width: 1
        //        border.color: r.borderColor
        color: r.color
        anchors.centerIn: r
    }
    Rectangle{
        id: xTip
        anchors.centerIn: r
        width: bg2.width
        height: bg2.height
        color: app.c1
        radius: width*0.5
        border.color: app.c2
        border.width: 2
        visible: false
        UText{
            id: labelText
            //text:  app.planetas[cAs.numAstro]+'\nSigno '+app.signos[cAs.objData.ns]+'\nGrado °'+cAs.objData.g+' \''+cAs.objData.m
            font.pixelSize: parent.width*0.125
            anchors.centerIn: parent
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            horizontalAlignment: Text.AlignHCenter
        }
        Timer{
            id: tResetTip
            running: false
            repeat: false
            interval: 5000
            onTriggered: {
                xPlanetas.cAs=xPlanetas
                xTip.visible=false
            }
        }
    }

    Item{
        id: xPlanetas
        anchors.fill: r
        property var cAs: xPlanetas
        onCAsChanged: {
            //if(cAs!==xPlanetas){
            xTip.visible=cAs!==xPlanetas
            //}
            labelText.text ='<b style="font-size:'+parseInt(labelText.font.pixelSize*1.35)+'px;">'+app.planetas[cAs.numAstro]+'</b><br /><b>'+app.signos[cAs.objData.ns]+'</b><br /><b>°'+cAs.objData.g+' \''+cAs.objData.m+'</b><br /><b>Casa '+cAs.objData.h+'</b>'
            xTip.anchors.bottom=cAs.top
            xTip.anchors.bottomMargin=r.fs*2
            xTip.anchors.horizontalCenter=cAs.horizontalCenter
            tResetTip.restart()
        }
        XAs{id:xSol;fs:r.fs;astro:'sun'; numAstro: 0}
        XAs{id:xLuna;fs:r.fs;astro:'moon'; numAstro: 1}
        XAs{id:xMercurio;fs:r.fs;astro:'mercury'; numAstro: 2}
        XAs{id:xVenus;fs:r.fs;astro:'venus'; numAstro: 3}
        XAs{id:xMarte;fs:r.fs;astro:'mars'; numAstro: 4}
        XAs{id:xJupiter;fs:r.fs;astro:'jupiter'; numAstro: 5}
        XAs{id:xSaturno;fs:r.fs;astro:'saturn'; numAstro: 6}
        XAs{id:xUrano;fs:r.fs;astro:'uranus'; numAstro: 7}
        XAs{id:xNeptuno;fs:r.fs;astro:'neptune'; numAstro: 8}
        XAs{id:xPluton;fs:r.fs;astro:'pluto'; numAstro: 9}
        XAs{id:xQuiron;fs:r.fs;astro:'hiron'; numAstro: 10}
        XAs{id:xProserpina;fs:r.fs;astro:'proserpina'; numAstro: 11}
        XAs{id:xSelena;fs:r.fs;astro:'selena'; numAstro: 12}
        XAs{id:xLilith;fs:r.fs;astro:'lilith'; numAstro: 13}
        function pressed(o){
            unik.speak(''+app.planetas[o.numAstro]+' en '+app.signos[o.objData.ns]+' en el grado '+o.objData.g+' en la casa '+o.objData.h)
        }
        function doublePressed(o){
            xConfirmSearchVideoBy.cuerpo=app.planetas[o.numAstro]
            xConfirmSearchVideoBy.signo=app.signos[o.objData.ns]
            xConfirmSearchVideoBy.casa=o.objData.h
            xConfirmSearchVideoBy.visible=true
        }
    }

    Rectangle{
        id: xLineasGrados
        width:  bg.width//+r.fs
        height: bg.height//+r.fs
        anchors.centerIn: bg
        color: 'transparent'
        border.width: 2//r.fs
        border.color: app.c2
        radius: width*0.5
        property int currentDegree: 20
        Repeater{
            model: 360
            Item{
                width: parent.width
                height: 2
                //color: 'red'
                rotation: index*1
                anchors.centerIn: parent
                antialiasing: true
                Rectangle{
                    width: r.fs*0.25
                    height: 2
                    color: app.c2
                    antialiasing: true
                    anchors.right: parent.left
                    Component.onCompleted: {
                        if(r.multiple(index, 5)){
                            width=r.fs*0.45
                        }
                    }
                }
                //                Rectangle{
                //                    visible: index===360-r.sigRot+xLineasGrados.currentDegree
                //                    width: r.fs*0.5
                //                    height: 2
                //                    color: 'red'
                //                    antialiasing: true
                //                    anchors.right: parent.left
                //                }
            }
        }
    }
    //    UText{
    //        id: info
    //        text: ''
    //        font.pixelSize: 28
    //        color: 'red'
    //        anchors.verticalCenter: parent.verticalCenter
    //        Rectangle{
    //            width: parent.width+app.fs*2
    //            height: parent.contentHeight+app.fs*2
    //            anchors.centerIn: parent
    //            z:parent.z-1
    //        }
    //    }
    function multiple(valor, multiple){
        let resto = valor % multiple;
        if(resto===0){
            return true;
        }else{
            return false;
        }
    }
    Component.onCompleted: {
        let json='{"params":{"ms":"1594667066141","n":"Florencia_Villalba","a":"1996","m":"01","d":"02","h":"14","min":"30","gmt":"-3","lat":"-34.6157437","lon":"-58.5733832"},"psc":{"sun":{"g":11,"m":36,"s":"cap","h":9,"rh":"ix"},"moon":{"g":7,"m":29,"s":"gem","h":2,"rh":"ii"},"mercury":{"g":1,"m":2,"s":"aqr","h":9,"rh":"ix"},"venus":{"g":14,"m":45,"s":"aqr","h":10,"rh":"x"},"mars":{"g":25,"m":31,"s":"cap","h":9,"rh":"ix"},"jupiter":{"g":29,"m":52,"s":"sgr","h":9,"rh":"ix"},"saturn":{"g":19,"m":31,"s":"psc","h":11,"rh":"xi"},"uranus":{"g":29,"m":27,"s":"cap","h":9,"rh":"ix"},"neptune":{"g":24,"m":44,"s":"cap","h":9,"rh":"ix"},"pluto":{"g":2,"m":0,"s":"sgr","h":8,"rh":"viii"},"n":{"g":23,"m":18,"s":"lib","h":6,"rh":"vi"},"s":{"g":23,"m":18,"s":"ari","h":12,"rh":"xii"},"hiron":{"g":13,"m":41,"s":"lib","h":6,"rh":"vi"},"proserpina":{"g":9,"m":51,"s":"sco","h":7,"rh":"vii"},"selena":{"g":0,"m":0,"s":"ari","h":11,"rh":"xi"},"lilith":{"g":10,"m":41,"s":"cnc","h":3,"rh":"iii"}},"pc":{"h1":{"s":"ari","g":29,"m":40},"h2":{"s":"tau","g":28,"m":14},"h3":{"s":"gem","g":29,"m":47},"h4":{"s":"leo","g":3,"m":16},"h5":{"s":"vir","g":5,"m":57},"h6":{"s":"lib","g":5,"m":3},"h7":{"s":"lib","g":29,"m":40},"h8":{"s":"sco","g":28,"m":14},"h9":{"s":"sgr","g":29,"m":47},"h10":{"s":"aqr","g":3,"m":16},"h11":{"s":"psc","g":5,"m":57},"h12":{"s":"ari","g":5,"m":3}}}'
        //{"params":{"ms":"1592110344809","n":"Alejo_Lombardi","a":"1999","m":"12","d":"29","h":"7","min":"20","gmt":"-3","lat":"-31.7413197","lon":"-60.5115471"},"psc":{"sun":{"g":0,"m":0,"s":"7","h":-1,"rh":"14"},"moon":{"g":5,"m":24,"s":"lib","h":9,"rh":"ix"},"mercury":{"g":27,"m":8,"s":"sgr","h":12,"rh":"xii"},"venus":{"g":27,"m":52,"s":"sco","h":11,"rh":"xi"},"mars":{"g":25,"m":35,"s":"aqr","h":2,"rh":"ii"},"jupiter":{"g":25,"m":8,"s":"ari","h":4,"rh":"iv"},"saturn":{"g":10,"m":27,"s":"tau","h":4,"rh":"iv"},"uranus":{"g":14,"m":39,"s":"aqr","h":1,"rh":"i"},"neptune":{"g":3,"m":5,"s":"aqr","h":1,"rh":"i"},"pluto":{"g":11,"m":21,"s":"sgr","h":11,"rh":"xi"},"n":{"g":4,"m":2,"s":"leo","h":7,"rh":"vii"},"s":{"g":4,"m":2,"s":"aqr","h":1,"rh":"i"},"hiron":{"g":11,"m":16,"s":"sgr","h":11,"rh":"xi"},"proserpina":{"g":11,"m":50,"s":"sco","h":10,"rh":"x"},"selena":{"g":0,"m":0,"s":"ari","h":3,"rh":"iii"},"lilith":{"g":23,"m":7,"s":"sgr","h":12,"rh":"xii"}},"pc":{"h1":{"s":"cap","g":23,"m":59},"h2":{"s":"aqr","g":16,"m":15},"h3":{"s":"psc","g":11,"m":59},"h4":{"s":"ari","g":12,"m":57},"h5":{"s":"tau","g":18,"m":3},"h6":{"s":"gem","g":22,"m":49},"h7":{"s":"cnc","g":23,"m":59},"h8":{"s":"leo","g":16,"m":15},"h9":{"s":"vir","g":11,"m":59},"h10":{"s":"lib","g":12,"m":57},"h11":{"s":"sco","g":18,"m":3},"h12":{"s":"sgr","g":22,"m":49}}}'

        //'{"params":{"ms":"1590969573745","n":"Ricardo","a":"1975","m":"06","d":"20","h":"23","min":"00","gmt":"-3","lat":"-35.484462","lon":"-69.5797495"},"psc":{"sun":{"g":29,"m":6,"s":"gem","h":5,"rh":"v"},"moon":{"g":26,"m":51,"s":"sco","h":10,"rh":"x"},"mercury":{"g":15,"m":6,"s":"gem","h":4,"rh":"iv"},"venus":{"g":14,"m":27,"s":"leo","h":6,"rh":"vi"},"mars":{"g":22,"m":45,"s":"ari","h":3,"rh":"iii"},"jupiter":{"g":20,"m":11,"s":"ari","h":3,"rh":"iii"},"saturn":{"g":19,"m":22,"s":"cnc","h":5,"rh":"v"},"uranus":{"g":28,"m":28,"s":"lib","h":9,"rh":"ix"},"neptune":{"g":9,"m":54,"s":"sgr","h":10,"rh":"x"},"pluto":{"g":6,"m":29,"s":"lib","h":8,"rh":"viii"},"n":{"g":0,"m":47,"s":"sgr","h":10,"rh":"x"},"s":{"g":0,"m":47,"s":"gem","h":4,"rh":"iv"},"hiron":{"g":27,"m":25,"s":"ari","h":3,"rh":"iii"},"proserpina":{"g":28,"m":3,"s":"lib","h":9,"rh":"ix"},"selena":{"g":0,"m":0,"s":"ari","h":2,"rh":"ii"},"lilith":{"g":15,"m":11,"s":"psc","h":1,"rh":"i"}},"pc":{"h1":{"s":"aqr","g":26,"m":9},"h2":{"s":"psc","g":20,"m":8},"h3":{"s":"ari","g":18,"m":46},"h4":{"s":"tau","g":21,"m":29},"h5":{"s":"gem","g":25,"m":27},"h6":{"s":"cnc","g":27,"m":24},"h7":{"s":"leo","g":26,"m":9},"h8":{"s":"vir","g":20,"m":8},"h9":{"s":"lib","g":18,"m":46},"h10":{"s":"sco","g":21,"m":29},"h11":{"s":"sgr","g":25,"m":27},"h12":{"s":"cap","g":27,"m":24}}}'
        setJson(json)
    }
    function setJson(j){
        r.objSigns = [0,0,0,0,0,0,0,0,0,0,0,0]
        let json=JSON.parse(j)
        if(!unik.folderExist('cns')){
            unik.mkdir('cns')
        }
        let fn='cns/'+json.params.ms+'_'+json.params.n+'.json'
        //logView.showLog('fn: '+fn)
        unik.setFile(fn, JSON.stringify(json))
        r.parent.visible=true
        r.visible=true
        //console.log('--->'+json.pc.h1.s)
        if(json.pc.h1.s==='ari'){
            r.sigRot=0+json.pc.h1.g
        }
        if(json.pc.h1.s==='tau'){
            r.sigRot=30+json.pc.h1.g
        }
        if(json.pc.h1.s==='gem'){
            r.sigRot=30*2+json.pc.h1.g
        }
        if(json.pc.h1.s==='cnc'){
            r.sigRot=30*3+json.pc.h1.g
        }
        if(json.pc.h1.s==='leo'){
            r.sigRot=30*4+json.pc.h1.g
        }
        if(json.pc.h1.s==='vir'){
            r.sigRot=30*5+json.pc.h1.g
        }
        if(json.pc.h1.s==='lib'){
            r.sigRot=30*6+json.pc.h1.g
        }
        if(json.pc.h1.s==='sco'){
            r.sigRot=30*7+json.pc.h1.g
        }
        if(json.pc.h1.s==='sgr'){
            r.sigRot=30*8+json.pc.h1.g
        }
        if(json.pc.h1.s==='cap'){
            r.sigRot=30*9+json.pc.h1.g
        }
        if(json.pc.h1.s==='aqr'){
            r.sigRot=30*10+json.pc.h1.g
        }
        if(json.pc.h1.s==='psc'){
            r.sigRot=30*11+json.pc.h1.g
        }

        r.ascSignIndex=r.objSignsNames.indexOf(json.pc.h1.s)
        r.ascDegree=json.pc.h1.g
        r.ascMinutes=json.pc.h1.m

        r.angleRotH1=json.pc.h1.g
        r.angleRotH2=json.pc.h2.g
        r.angleRotH3=json.pc.h3.g
        r.angleRotH4=json.pc.h4.g
        r.angleRotH5=json.pc.h5.g
        r.angleRotH6=json.pc.h6.g

        r.sh1=r.objSignsNames.indexOf(json.pc.h1.s)
        r.sh2=r.objSignsNames.indexOf(json.pc.h2.s)
        r.sh3=r.objSignsNames.indexOf(json.pc.h3.s)
        r.sh4=r.objSignsNames.indexOf(json.pc.h4.s)
        r.sh5=r.objSignsNames.indexOf(json.pc.h5.s)
        r.sh6=r.objSignsNames.indexOf(json.pc.h6.s)

        //        let diffHouse1=0
        //        let vd1=json.pc.h1.g-30
        //        let rotAxis1=30+vd1+30-json.pc.h2.g
        //        if(json.pc.h2.g-json.pc.h1.g){
        //        }

        //        let diffHouse2=json.pc.h3.g-json.pc.h2.g
        //        let diffHouse3=json.pc.h4.g-json.pc.h3.g
        //        let diffHouse4=json.pc.h5.g-json.pc.h4.g

        //        info.text=json.pc.h1.g+' '+json.pc.h2.g+' '+json.pc.h3.g+' '+json.pc.h4.g
        //        info.text+='\n'+rotAxis1
        //info.text+='\n'+diffHouse1+' '+diffHouse2+' '+diffHouse3+' '+diffHouse4
        r.cAscName=app.signos[r.objSignsNames.indexOf(json.pc.h1.s)]

        let vRSol=30*getSigIndex(json.psc.sun.s)
        let vRLuna=30*getSigIndex(json.psc.moon.s)
        let vRMer=30*getSigIndex(json.psc.mercury.s)
        let vRVenus=30*getSigIndex(json.psc.venus.s)
        let vRMarte=30*getSigIndex(json.psc.mars.s)
        let vRJupiter=30*getSigIndex(json.psc.jupiter.s)
        let vRSaturno=30*getSigIndex(json.psc.saturn.s)
        let vRUrano=30*getSigIndex(json.psc.uranus.s)
        let vRNeptuno=30*getSigIndex(json.psc.neptune.s)
        let vRPluto=30*getSigIndex(json.psc.pluto.s)
        let vRQuiron=30*getSigIndex(json.psc.hiron.s)
        let vRProserpina=30*getSigIndex(json.psc.proserpina.s)
        let vRSelena=30*getSigIndex(json.psc.selena.s)
        let vRLilith=30*getSigIndex(json.psc.lilith.s)

        let jo
        let o

        jo=json.psc.sun
        xSol.rotation=0-vRSol+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xSol.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.moon
        xLuna.rotation=0-vRLuna+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xLuna.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.mercury
        xMercurio.rotation=0-vRMer+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xMercurio.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.venus
        xVenus.rotation=0-vRVenus+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xVenus.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.mars
        xMarte.rotation=0-vRMarte+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xMarte.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.jupiter
        xJupiter.rotation=0-vRJupiter+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xJupiter.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++


        jo=json.psc.saturn
        xSaturno.rotation=0-vRSaturno+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xSaturno.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.uranus
        xUrano.rotation=0-vRUrano+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xUrano.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.neptune
        xNeptuno.rotation=0-vRNeptuno+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xNeptuno.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.pluto
        xPluton.rotation=0-vRPluto+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xPluton.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.hiron
        xQuiron.rotation=0-vRQuiron+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xQuiron.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.proserpina
        xProserpina.rotation=0-vRProserpina+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xProserpina.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.selena
        xSelena.rotation=0-vRSelena+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xSelena.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.lilith
        xLilith.rotation=0-vRLilith+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xLilith.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++
    }
    function getSigIndex(s){
        let ms=['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
        return ms.indexOf(s)
    }

}
