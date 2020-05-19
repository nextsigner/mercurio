
import QtQuick 2.0
import QtGraphicalEffects 1.0
import "func.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: width
    color: app.c1
    antialiasing: true
    property int fs: r.width*0.05
    property var arrayCasas1: ['Asc', 'II', 'III', 'IV', 'V', 'VI']
    property var arrayCasas2: ['VII', 'VII', 'IX', 'X', 'XI', 'XII']
    property string borderColor: app.c2
    property var arrayElementsColors: ['#E7B70B', 'brown', '#16E9F6', '#118CC8']
    property int sigRot: 30
    property color axisColor: 'red'
    signal doubleClick
    MouseArea{
        anchors.fill: r
        onDoubleClicked: r.doubleClick()
    }
    Item {
        anchors.fill: parent
        Repeater{
            model: r.arrayCasas1
            Item{
                width: r.width+r.fs
                height: 3
                anchors.centerIn: parent
                rotation: 0-index*30
                Rectangle{
                    width: parent.width-r.fs
                    height: 1
                    color: 'red'
                    anchors.centerIn: parent
                    antialiasing: true
                }
                Text{
                    text: modelData
                    font.pixelSize: r.fs
                    color: 'white'
                    anchors.right: parent.left
                    //anchors.rightMargin: r.fs
                    anchors.verticalCenter: parent.verticalCenter
                    rotation: index*30
                }
                Text{
                    text: r.arrayCasas2[index]
                    font.pixelSize: r.fs
                    color: 'white'
                    anchors.left: parent.right
                    //anchors.rightMargin: r.fs
                    anchors.verticalCenter: parent.verticalCenter
                    rotation: index*30
                }
            }
        }
    }

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
                property color c: index===0?'gray':'green'
                Repeater{
                    id: repG
                    model: 30
                    Rectangle{
                        id: xG
                        width: parent.width
                        height: r.fs*0.5
                        //anchors.centerIn: parent
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

                //                Text{
                //                    text: app.signos[index]
                //                    font.pixelSize: r.fs
                //                    color: 'white'
                //                    anchors.right: parent.left
                //                    //anchors.rightMargin: r.fs
                //                    anchors.verticalCenter: parent.verticalCenter
                //                    rotation: index*30
                //                }

            }
        }
    }
    Item {
        anchors.fill: parent
        Repeater{
            model: 2
            Item{
                width: r.width
                height: 2
                anchors.centerIn: parent
                rotation: 0-index*90
                Rectangle{
                    id: lineAxis
                    width: parent.width-r.fs
                    height: 1
                    color: r.axisColor
                    anchors.centerIn: parent
                    antialiasing: true
                }
                Item{
                    width: r.fs*0.5
                    height: width
                    anchors.left: parent.left
                    anchors.leftMargin: 0-width*0.5
                    anchors.verticalCenter: parent.verticalCenter
                    antialiasing: true
                    visible: index===0
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            tagHor.visible=true
                        }
                        onExited: tagHor.visible=false
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
    Item{
        id: xPlanetas
        anchors.fill: r
        Item{
            id: xSol
            width: parent.width-r.fs*3
            height: 1
            anchors.centerIn: parent
            Item{
                width: r.fs*1.5
                height: width
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                Image {
                    source: "./resources/imgs/planetas/sol.png"
                    width: parent.width
                    height: width
                    anchors.centerIn: parent
                    rotation: 0-parent.parent.rotation
                }
            }
        }
        Item{
            id: xLuna
            width: parent.width-r.fs*3
            height: 1
            anchors.centerIn: parent
            Item{
                width: r.fs*1.5
                height: width
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                Image {
                    source: "./resources/imgs/planetas/luna.png"
                    width: parent.width
                    height: width
                    anchors.centerIn: parent
                    rotation: 0-parent.parent.rotation
                }
            }
        }
        Item{
            id: xMercurio
            width: parent.width-r.fs*3
            height: 1
            anchors.centerIn: parent
            Item{
                width: r.fs*1.5
                height: width
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                Image {
                    source: "./resources/imgs/planetas/mercurio.png"
                    width: parent.width
                    height: width
                    anchors.centerIn: parent
                    rotation: 0-parent.parent.rotation
                }
            }
        }
        Item{
            id: xVenus
            width: parent.width-r.fs*3
            height: 1
            anchors.centerIn: parent
            Item{
                width: r.fs*1.5
                height: width
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                Image {
                    source: "./resources/imgs/planetas/venus.png"
                    width: parent.width
                    height: width
                    anchors.centerIn: parent
                    rotation: 0-parent.parent.rotation
                }
            }
        }
    }
    Component.onCompleted: {
        let json='{
"psc":{
"sun":{"g":28,"m":57,"s":"gem","h":5,"rh":"v"}
,"moon":{"g":24,"m":36,"s":"sco","h":10,"rh":"x"}
,"mercury":{"g":15,"m":7,"s":"gem","h":5,"rh":"v"}
,"venus":{"g":14,"m":18,"s":"leo","h":6,"rh":"vi"}
,"mars":{"g":22,"m":38,"s":"ari","h":3,"rh":"iii"}
,"jupiter":{"g":20,"m":10,"s":"ari","h":3,"rh":"iii"}
,"saturn":{"g":19,"m":20,"s":"cnc","h":6,"rh":"vi"}
,"uranus":{"g":28,"m":28,"s":"lib","h":10,"rh":"x"}
,"neptune":{"g":9,"m":54,"s":"sgr","h":11,"rh":"xi"}
,"pluto":{"g":6,"m":29,"s":"lib","h":9,"rh":"ix"}
,"n":{"g":0,"m":47,"s":"sgr","h":10,"rh":"x"}
,"s":{"g":0,"m":47,"s":"gem","h":4,"rh":"iv"}
,"hiron":{"g":27,"m":25,"s":"ari","h":4,"rh":"iv"}
,"proserpina":{"g":28,"m":3,"s":"lib","h":10,"rh":"x"}
,"selena":{"g":0,"m":0,"s":"ari","h":2,"rh":"ii"}
,"lilith":{"g":15,"m":10,"s":"psc","h":1,"rh":"i"}
}
,"pc":{
"h1":{"s":"aqr","g":-27,"m":10}
,"h2":{"s":"psc","g":16,"m":23}
,"h3":{"s":"ari","g":5,"m":36}
,"h4":{"s":"ari","g":24,"m":49}
,"h5":{"s":"gem","g":5,"m":36}
,"h6":{"s":"cnc","g":16,"m":23}
,"h7":{"s":"leo","g":-27,"m":10}
,"h8":{"s":"vir","g":16,"m":23}
,"h9":{"s":"lib","g":5,"m":36}
,"h10":{"s":"lib","g":24,"m":49}
,"h11":{"s":"sgr","g":5,"m":36}
,"h12":{"s":"cap","g":16,"m":23}
}
}
'
        //setJson(json)
    }
    function setJson(j){
        let json=JSON.parse(j)
        if(!unik.folderExist('cns')){
            unik.mkdir('cns')
        }
        let fn='cns/'+json.params.ms+'_'+json.params.n+'.json'
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

        let vRSol=30*getSigIndex(json.psc.sun.s)
        let vRLuna=30*getSigIndex(json.psc.moon.s)
        let vRMer=30*getSigIndex(json.psc.mercury.s)
        let vRVenus=30*getSigIndex(json.psc.venus.s)
        xSol.rotation=0-vRSol+r.sigRot-json.psc.sun.g
        xLuna.rotation=0-vRLuna+r.sigRot-json.psc.moon.g
        xMercurio.rotation=0-vRMer+r.sigRot-json.psc.mercury.g
        xVenus.rotation=0-vRVenus+r.sigRot-json.psc.venus.g

        //logView.showLog(json.pc.h1.g)
        //logView.showLog(json.pc.h1.m)
    }
    function getSigIndex(s){
        let ms=['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
        return ms.indexOf(s)
    }

}
