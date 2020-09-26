
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

    signal cnLoaded(string nombre, string dia, string mes, string anio, string hora, string minuto, string lon, string lat, string ciudad)
    signal doubleClick
    signal posChanged(int px, int py)

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
                        id: colorOverlayIconoSig
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
                        MouseArea{
                            width: iconoSig.width
                            height: width
                            anchors.centerIn: parent
                            onDoubleClicked: {
                                xAsData.addXAsTextData(app.signos[index], -1)
                            }
                            //                            Rectangle{
                            //                                anchors.fill: parent
                            //                                color: 'red'
                            //                                radius: width*0.5
                            //                                opacity: 0.5
                            //                            }
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
                            //radius: width*0.5
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

                    Item{
                        id:nh2
                        width: r.fs
                        height: r.fs*0.33
                        anchors.right: parent.left
                        anchors.rightMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false
                        Row{
                            spacing: r.fs*0.33/3
                            anchors.centerIn: parent
                            Rectangle{
                                width: r.fs*0.33
                                height: width
                                radius: width*0.5
                                color: app.c2
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Rectangle{
                                width: r.fs*0.33
                                height: width
                                radius: width*0.5
                                color: app.c2
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                    Item{
                        id:nh3
                        width: r.fs
                        height: r.fs*0.33
                        anchors.right: parent.left
                        anchors.rightMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false
                        Row{
                            spacing: r.fs*0.25/4
                            anchors.centerIn: parent
                            Rectangle{
                                width: r.fs*0.33
                                height: width
                                radius: width*0.5
                                color: app.c2
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Rectangle{
                                width: r.fs*0.33
                                height: width
                                radius: width*0.5
                                color: app.c2
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Rectangle{
                                width: r.fs*0.33
                                height: width
                                radius: width*0.5
                                color: app.c2
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                    Item{
                        id:nh4
                        width: r.fs
                        height: r.fs*0.33
                        anchors.right: parent.left
                        anchors.rightMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false
                        Column{
                            spacing: r.fs*0.25/4
                            anchors.centerIn: parent
                            Row{
                                spacing: r.fs*0.25/4
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                            Row{
                                spacing: r.fs*0.25/4
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                    }
                    Rectangle{
                        id:nh5
                        width: r.fs*0.75
                        height: width
                        radius: width*0.5
                        color: app.c2
                        anchors.right: parent.left
                        anchors.rightMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false
                    }
                    Item{
                        id:nh6
                        width: r.fs
                        height: r.fs*0.33
                        anchors.right: parent.left
                        anchors.rightMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false
                        Row{
                            spacing: r.fs*0.33/3
                            anchors.centerIn: parent
                            Rectangle{
                                width: r.fs*0.75
                                height: width
                                radius: width*0.5
                                color: app.c2
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Rectangle{
                                width: r.fs*0.33
                                height: width
                                radius: width*0.5
                                color: app.c2
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                    Item{
                        id:nh7
                        width: r.fs
                        height: r.fs*0.33
                        anchors.left: parent.right
                        anchors.leftMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false
                        Row{
                            spacing: r.fs*0.33/3
                            anchors.centerIn: parent
                            Column{
                                spacing: r.fs*0.33/3
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    //anchors.verticalCenter: parent.verticalCenter
                                }
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    //anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                            Rectangle{
                                width: r.fs*0.75
                                height: width
                                radius: width*0.5
                                color: app.c2
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                    Item{
                        id:nh8
                        width: r.fs
                        height: r.fs*0.33
                        anchors.left: parent.right
                        anchors.leftMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false
                        Row{
                            spacing: r.fs*0.33/3
                            anchors.centerIn: parent
                            Column{
                                spacing: r.fs*0.33/3
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    //anchors.verticalCenter: parent.verticalCenter
                                }
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    //anchors.verticalCenter: parent.verticalCenter
                                }
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    //anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                            Rectangle{
                                width: r.fs*0.75
                                height: width
                                radius: width*0.5
                                color: app.c2
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                    Item{
                        id:nh9
                        width: r.fs
                        height: r.fs*0.33
                        anchors.left: parent.right
                        anchors.leftMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false
                        Row{
                            spacing: r.fs*0.33/3
                            anchors.centerIn: parent
                            Column{
                                spacing: r.fs*0.33/3
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    //anchors.verticalCenter: parent.verticalCenter
                                }
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    //anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                            Column{
                                spacing: r.fs*0.33/3
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    //anchors.verticalCenter: parent.verticalCenter
                                }
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                    //anchors.verticalCenter: parent.verticalCenter
                                }
                            }

                            Rectangle{
                                width: r.fs*0.75
                                height: width
                                radius: width*0.5
                                color: app.c2
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                    Item{
                        id:nh10
                        width: r.fs
                        height: r.fs*0.33
                        anchors.left: parent.right
                        anchors.leftMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false
                        Column{
                            spacing: r.fs*0.33/3
                            anchors.centerIn: parent
                            Rectangle{
                                width: r.fs*0.75
                                height: width
                                radius: width*0.5
                                color: app.c2
                            }
                            Rectangle{
                                width: r.fs*0.75
                                height: width
                                radius: width*0.5
                                color: app.c2
                            }
                        }
                    }
                    Item{
                        id:nh11
                        width: r.fs
                        height: r.fs*0.33
                        anchors.left: parent.right
                        anchors.leftMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false
                        Row{
                            anchors.centerIn: parent
                            Rectangle{
                                width: r.fs*0.33
                                height: width
                                radius: width*0.5
                                color: app.c2
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            Column{
                                spacing: r.fs*0.33/3
                                Rectangle{
                                    width: r.fs*0.75
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                }
                                Rectangle{
                                    width: r.fs*0.75
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                }
                            }
                        }
                    }
                    Item{
                        id:nh12
                        width: r.fs
                        height: r.fs*0.33
                        anchors.left: parent.right
                        anchors.leftMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false
                        Row{
                            anchors.centerIn: parent
                            Column{
                                spacing: r.fs*0.33/3
                                anchors.verticalCenter: parent.verticalCenter
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                }
                                Rectangle{
                                    width: r.fs*0.33
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                }
                            }
                            Column{
                                spacing: r.fs*0.33/3
                                Rectangle{
                                    width: r.fs*0.75
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                }
                                Rectangle{
                                    width: r.fs*0.75
                                    height: width
                                    radius: width*0.5
                                    color: app.c2
                                }
                            }
                        }
                    }
                    Text{
                        id: l1
                        text: ''
                        font.pixelSize: r.fs
                        color: app.c2
                        anchors.right: parent.left
                        anchors.rightMargin: r.fs*0.5
                        anchors.verticalCenter: parent.verticalCenter
                        horizontalAlignment: index!==0?Text.AlignHCenter:Text.AlignRight
                    }
                    Timer{
                        running: true
                        repeat: true
                        interval: 500
                        onTriggered: axis.setRot()
                    }
                    function setRot() {
                        //console.log('r.ascSignIndex: '+r.ascSignIndex+' index: '+index+' r.sh4: '+r.sh4)
                        if(index===r.sh1){
                            //axis.color='#88ff33'
                            l1.text='Asc\n'+r.cAscName+'\n°'+r.ascDegree+' \''+r.ascMinutes
                            rectH1.visible=true
                            nh7.visible=true
                            //                            l2.text='VII'
                            //                            l2.rotation=0//r.angleRotH1
                            axis.rotation=0-r.angleRotH1
                        }else if(index===r.sh2){
                            //axis.color='#ff3388'
                            axis.rotation=0-r.angleRotH2
                            nh2.visible=true
                            nh8.visible=true
                            //                            l1.text='II'
                            //                            l1.rotation=0-axis.rotation
                            //                            l2.text='VIII'
                            //                            l2.rotation=l1.rotation
                        }else if(index===r.sh3){
                            //axis.color='#88ff33'
                            axis.rotation=0-r.angleRotH3
                            nh3.visible=true
                            nh9.visible=true
                            //                            l1.text='III'
                            //                            l1.rotation=30-axis.rotation
                            //                            l2.text='IX'
                            //                            l2.rotation=l1.rotation
                        }else if(index===r.sh4){
                            //axis.color='#ff8833'
                            axis.rotation=0-r.angleRotH4
                            cirH10.visible=true
                            nh4.visible=true
                            nh10.visible=true
                            //                            l1.text='IV'
                            //                            l1.rotation=90//axis.parent.rotation+60
                            //                            l2.text='X'
                            //                            l2.rotation=l1.rotation
                        }else if(index===r.sh5){
                            //axis.color='#88dd33'
                            axis.rotation=0-r.angleRotH5
                            nh5.visible=true
                            nh11.visible=true
                        }else if(index===r.sh6){
                            //axis.color='#99ff22'
                            axis.rotation=0-r.angleRotH6
                            nh6.visible=true
                            nh12.visible=true
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
            labelText.text =cAs!==xPlanetas?'<b style="font-size:'+parseInt(labelText.font.pixelSize*1.35)+'px;">'+app.planetas[cAs.numAstro]+'</b><br /><b>'+app.signos[cAs.objData.ns]+'</b><br /><b>°'+cAs.objData.g+' \''+cAs.objData.m+'</b><br /><b>Casa '+cAs.objData.h+'</b>':'Mercurio'
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
        XAs{id:xNodoPS;fs:r.fs;astro:'nodopolarsur'; numAstro: 14}
        XAs{id:xNodoPN;fs:r.fs;astro:'nodopolarnorte'; numAstro: 15}
        function pressed(o){
            unik.speak(''+app.planetas[o.numAstro]+' en '+app.signos[o.objData.ns]+' en el grado '+o.objData.g+' en la casa '+o.objData.h)
        }
        function doublePressed(o){
            unik.speak(" ")
            xConfirmSearchVideoBy.cuerpo=app.planetas[o.numAstro]
            xConfirmSearchVideoBy.signo=app.signos[o.objData.ns]
            xConfirmSearchVideoBy.casa=o.objData.h
            let link=r.getYtVideoUrl(xConfirmSearchVideoBy.cuerpo, xConfirmSearchVideoBy.casa)
            console.log('link: '+link)
            xConfirmSearchVideoBy.url1=link
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
    function getYtVideoUrl(cuerpo, casa){
        let ret=''
        let d=unik.getFile('ytvrul.json')
        console.log('cuerpo: '+cuerpo)
        let json=JSON.parse(d)
        if(json[''+cuerpo]&&json[''+cuerpo]["h"+casa]){
            let link=json[''+cuerpo]["h"+casa].link
            ret=link
        }
        return ret;
    }
    function multiple(valor, multiple){
        let resto = valor % multiple;
        if(resto===0){
            return true;
        }else{
            return false;
        }
    }
    Component.onCompleted: {
        let json='{
"params":{
"ms":"1600209583608","n":"ricardoprueba","a":"1975","m":"06","d":"20","h":"23","min":"00","gmt":"-3","lat":"-34.57","lon":"-69.47","ciudad":"malargue"}
,"psc":{
"sun":{"g":29,"m":6,"s":"gem","h":5,"rh":"v"}
,"moon":{"g":26,"m":51,"s":"sco","h":10,"rh":"x"}
,"mercury":{"g":15,"m":6,"s":"gem","h":4,"rh":"iv"}
,"venus":{"g":14,"m":27,"s":"leo","h":6,"rh":"vi"}
,"mars":{"g":22,"m":45,"s":"ari","h":3,"rh":"iii"}
,"jupiter":{"g":20,"m":11,"s":"ari","h":3,"rh":"iii"}
,"saturn":{"g":19,"m":22,"s":"cnc","h":5,"rh":"v"}
,"uranus":{"g":28,"m":28,"s":"lib","h":9,"rh":"ix"}
,"neptune":{"g":9,"m":54,"s":"sgr","h":10,"rh":"x"}
,"pluto":{"g":6,"m":29,"s":"lib","h":8,"rh":"viii"}
,"n":{"g":0,"m":47,"s":"sgr","h":10,"rh":"x"}
,"s":{"g":0,"m":47,"s":"gem","h":4,"rh":"iv"}
,"hiron":{"g":27,"m":25,"s":"ari","h":3,"rh":"iii"}
,"proserpina":{"g":28,"m":3,"s":"lib","h":9,"rh":"ix"}
,"selena":{"g":0,"m":0,"s":"ari","h":2,"rh":"ii"}
,"lilith":{"g":15,"m":11,"s":"psc","h":1,"rh":"i"}
}
,"pc":{
"h1":{"s":"aqr","g":25,"m":59}
,"h2":{"s":"psc","g":-20,"m":10}
,"h3":{"s":"ari","g":18,"m":55}
,"h4":{"s":"tau","g":21,"m":36}
,"h5":{"s":"gem","g":25,"m":22}
,"h6":{"s":"cnc","g":27,"m":12}
,"h7":{"s":"leo","g":25,"m":59}
,"h8":{"s":"vir","g":-20,"m":10}
,"h9":{"s":"lib","g":18,"m":55}
,"h10":{"s":"sco","g":21,"m":36}
,"h11":{"s":"sgr","g":25,"m":22}
,"h12":{"s":"cap","g":27,"m":12}
}
,"jsonHades":{"Cuerpos":{"SiderealTime":55004.000589683696,"JulianDay":2442584.5,"Order":0,"CelestialBodies":[{"TotalDegree":89.08333333333333,"Name":"Sun","IsRetrograde":false},{"TotalDegree":236.825,"Name":"Moon","IsRetrograde":false},{"TotalDegree":75.09166666666667,"Name":"Mercury","IsRetrograde":true},{"TotalDegree":134.475,"Name":"Venus","IsRetrograde":false},{"TotalDegree":22.758333333333333,"Name":"Mars","IsRetrograde":false},{"TotalDegree":20.208333333333332,"Name":"Jupiter","IsRetrograde":false},{"TotalDegree":109.40833333333333,"Name":"Saturn","IsRetrograde":false},{"TotalDegree":208.5,"Name":"Uranus","IsRetrograde":true},{"TotalDegree":249.9,"Name":"Neptune","IsRetrograde":true},{"TotalDegree":186.5,"Name":"Pluto","IsRetrograde":false},{"TotalDegree":239.5,"Name":"MeanNode","IsRetrograde":true},{"TotalDegree":240.8,"Name":"TrueNode","IsRetrograde":false},{"TotalDegree":27.40833333333333,"Name":"Chiron","IsRetrograde":false},{"TotalDegree":134.475,"Name":"Vertex","IsRetrograde":false},{"TotalDegree":48.13333333333333,"Name":"Ceres","IsRetrograde":false},{"TotalDegree":3.5083333333333333,"Name":"Pallas","IsRetrograde":false},{"TotalDegree":87.14999999999999,"Name":"Juno","IsRetrograde":false},{"TotalDegree":356.51666666666665,"Name":"Vesta","IsRetrograde":false}]},"Aspectos":[{"type":"Trine","fromDeg":89.08333333333333,"toDeg":208.5,"celestialBodies":[{"TotalDegree":89.08333333333333,"Name":"Sun","IsRetrograde":false},{"TotalDegree":208.5,"Name":"Uranus","IsRetrograde":true}]},{"type":"Sextile","fromDeg":89.08333333333333,"toDeg":27.40833333333333,"celestialBodies":[{"TotalDegree":89.08333333333333,"Name":"Sun","IsRetrograde":false},{"TotalDegree":27.40833333333333,"Name":"Chiron","IsRetrograde":false}]},{"type":"Square","fromDeg":89.08333333333333,"toDeg":3.5083333333333333,"celestialBodies":[{"TotalDegree":89.08333333333333,"Name":"Sun","IsRetrograde":false},{"TotalDegree":3.5083333333333333,"Name":"Pallas","IsRetrograde":false}]},{"type":"Conjunction","fromDeg":89.08333333333333,"toDeg":87.14999999999999,"celestialBodies":[{"TotalDegree":89.08333333333333,"Name":"Sun","IsRetrograde":false},{"TotalDegree":87.14999999999999,"Name":"Juno","IsRetrograde":false}]},{"type":"Conjunction","fromDeg":236.825,"toDeg":239.5,"celestialBodies":[{"TotalDegree":236.825,"Name":"Moon","IsRetrograde":false},{"TotalDegree":239.5,"Name":"MeanNode","IsRetrograde":true}]},{"type":"Conjunction","fromDeg":236.825,"toDeg":240.8,"celestialBodies":[{"TotalDegree":236.825,"Name":"Moon","IsRetrograde":false},{"TotalDegree":240.8,"Name":"TrueNode","IsRetrograde":false}]},{"type":"Trine","fromDeg":236.825,"toDeg":356.51666666666665,"celestialBodies":[{"TotalDegree":236.825,"Name":"Moon","IsRetrograde":false},{"TotalDegree":356.51666666666665,"Name":"Vesta","IsRetrograde":false}]},{"type":"Sextile","fromDeg":75.09166666666667,"toDeg":134.475,"celestialBodies":[{"TotalDegree":75.09166666666667,"Name":"Mercury","IsRetrograde":true},{"TotalDegree":134.475,"Name":"Venus","IsRetrograde":false}]},{"type":"Opposition","fromDeg":75.09166666666667,"toDeg":249.9,"celestialBodies":[{"TotalDegree":75.09166666666667,"Name":"Mercury","IsRetrograde":true},{"TotalDegree":249.9,"Name":"Neptune","IsRetrograde":true}]},{"type":"Sextile","fromDeg":75.09166666666667,"toDeg":134.475,"celestialBodies":[{"TotalDegree":75.09166666666667,"Name":"Mercury","IsRetrograde":true},{"TotalDegree":134.475,"Name":"Vertex","IsRetrograde":false}]},{"type":"Sextile","fromDeg":134.475,"toDeg":75.09166666666667,"celestialBodies":[{"TotalDegree":134.475,"Name":"Venus","IsRetrograde":false},{"TotalDegree":75.09166666666667,"Name":"Mercury","IsRetrograde":true}]},{"type":"Trine","fromDeg":134.475,"toDeg":20.208333333333332,"celestialBodies":[{"TotalDegree":134.475,"Name":"Venus","IsRetrograde":false},{"TotalDegree":20.208333333333332,"Name":"Jupiter","IsRetrograde":false}]},{"type":"Trine","fromDeg":134.475,"toDeg":249.9,"celestialBodies":[{"TotalDegree":134.475,"Name":"Venus","IsRetrograde":false},{"TotalDegree":249.9,"Name":"Neptune","IsRetrograde":true}]},{"type":"Conjunction","fromDeg":134.475,"toDeg":134.475,"celestialBodies":[{"TotalDegree":134.475,"Name":"Venus","IsRetrograde":false},{"TotalDegree":134.475,"Name":"Vertex","IsRetrograde":false}]},{"type":"Square","fromDeg":134.475,"toDeg":48.13333333333333,"celestialBodies":[{"TotalDegree":134.475,"Name":"Venus","IsRetrograde":false},{"TotalDegree":48.13333333333333,"Name":"Ceres","IsRetrograde":false}]},{"type":"Conjunction","fromDeg":22.758333333333333,"toDeg":20.208333333333332,"celestialBodies":[{"TotalDegree":22.758333333333333,"Name":"Mars","IsRetrograde":false},{"TotalDegree":20.208333333333332,"Name":"Jupiter","IsRetrograde":false}]},{"type":"Square","fromDeg":22.758333333333333,"toDeg":109.40833333333333,"celestialBodies":[{"TotalDegree":22.758333333333333,"Name":"Mars","IsRetrograde":false},{"TotalDegree":109.40833333333333,"Name":"Saturn","IsRetrograde":false}]},{"type":"Opposition","fromDeg":22.758333333333333,"toDeg":208.5,"celestialBodies":[{"TotalDegree":22.758333333333333,"Name":"Mars","IsRetrograde":false},{"TotalDegree":208.5,"Name":"Uranus","IsRetrograde":true}]},{"type":"Conjunction","fromDeg":22.758333333333333,"toDeg":27.40833333333333,"celestialBodies":[{"TotalDegree":22.758333333333333,"Name":"Mars","IsRetrograde":false},{"TotalDegree":27.40833333333333,"Name":"Chiron","IsRetrograde":false}]},{"type":"Sextile","fromDeg":22.758333333333333,"toDeg":87.14999999999999,"celestialBodies":[{"TotalDegree":22.758333333333333,"Name":"Mars","IsRetrograde":false},{"TotalDegree":87.14999999999999,"Name":"Juno","IsRetrograde":false}]},{"type":"Trine","fromDeg":20.208333333333332,"toDeg":134.475,"celestialBodies":[{"TotalDegree":20.208333333333332,"Name":"Jupiter","IsRetrograde":false},{"TotalDegree":134.475,"Name":"Venus","IsRetrograde":false}]},{"type":"Conjunction","fromDeg":20.208333333333332,"toDeg":22.758333333333333,"celestialBodies":[{"TotalDegree":20.208333333333332,"Name":"Jupiter","IsRetrograde":false},{"TotalDegree":22.758333333333333,"Name":"Mars","IsRetrograde":false}]},{"type":"Square","fromDeg":20.208333333333332,"toDeg":109.40833333333333,"celestialBodies":[{"TotalDegree":20.208333333333332,"Name":"Jupiter","IsRetrograde":false},{"TotalDegree":109.40833333333333,"Name":"Saturn","IsRetrograde":false}]},{"type":"Trine","fromDeg":20.208333333333332,"toDeg":134.475,"celestialBodies":[{"TotalDegree":20.208333333333332,"Name":"Jupiter","IsRetrograde":false},{"TotalDegree":134.475,"Name":"Vertex","IsRetrograde":false}]},{"type":"Square","fromDeg":109.40833333333333,"toDeg":22.758333333333333,"celestialBodies":[{"TotalDegree":109.40833333333333,"Name":"Saturn","IsRetrograde":false},{"TotalDegree":22.758333333333333,"Name":"Mars","IsRetrograde":false}]},{"type":"Square","fromDeg":109.40833333333333,"toDeg":20.208333333333332,"celestialBodies":[{"TotalDegree":109.40833333333333,"Name":"Saturn","IsRetrograde":false},{"TotalDegree":20.208333333333332,"Name":"Jupiter","IsRetrograde":false}]},{"type":"Sextile","fromDeg":109.40833333333333,"toDeg":48.13333333333333,"celestialBodies":[{"TotalDegree":109.40833333333333,"Name":"Saturn","IsRetrograde":false},{"TotalDegree":48.13333333333333,"Name":"Ceres","IsRetrograde":false}]},{"type":"Trine","fromDeg":208.5,"toDeg":89.08333333333333,"celestialBodies":[{"TotalDegree":208.5,"Name":"Uranus","IsRetrograde":true},{"TotalDegree":89.08333333333333,"Name":"Sun","IsRetrograde":false}]},{"type":"Opposition","fromDeg":208.5,"toDeg":22.758333333333333,"celestialBodies":[{"TotalDegree":208.5,"Name":"Uranus","IsRetrograde":true},{"TotalDegree":22.758333333333333,"Name":"Mars","IsRetrograde":false}]},{"type":"Opposition","fromDeg":208.5,"toDeg":27.40833333333333,"celestialBodies":[{"TotalDegree":208.5,"Name":"Uranus","IsRetrograde":true},{"TotalDegree":27.40833333333333,"Name":"Chiron","IsRetrograde":false}]},{"type":"Trine","fromDeg":208.5,"toDeg":87.14999999999999,"celestialBodies":[{"TotalDegree":208.5,"Name":"Uranus","IsRetrograde":true},{"TotalDegree":87.14999999999999,"Name":"Juno","IsRetrograde":false}]},{"type":"Opposition","fromDeg":249.9,"toDeg":75.09166666666667,"celestialBodies":[{"TotalDegree":249.9,"Name":"Neptune","IsRetrograde":true},{"TotalDegree":75.09166666666667,"Name":"Mercury","IsRetrograde":true}]},{"type":"Trine","fromDeg":249.9,"toDeg":134.475,"celestialBodies":[{"TotalDegree":249.9,"Name":"Neptune","IsRetrograde":true},{"TotalDegree":134.475,"Name":"Venus","IsRetrograde":false}]},{"type":"Sextile","fromDeg":249.9,"toDeg":186.5,"celestialBodies":[{"TotalDegree":249.9,"Name":"Neptune","IsRetrograde":true},{"TotalDegree":186.5,"Name":"Pluto","IsRetrograde":false}]},{"type":"Trine","fromDeg":249.9,"toDeg":134.475,"celestialBodies":[{"TotalDegree":249.9,"Name":"Neptune","IsRetrograde":true},{"TotalDegree":134.475,"Name":"Vertex","IsRetrograde":false}]},{"type":"Sextile","fromDeg":186.5,"toDeg":249.9,"celestialBodies":[{"TotalDegree":186.5,"Name":"Pluto","IsRetrograde":false},{"TotalDegree":249.9,"Name":"Neptune","IsRetrograde":true}]},{"type":"Opposition","fromDeg":186.5,"toDeg":3.5083333333333333,"celestialBodies":[{"TotalDegree":186.5,"Name":"Pluto","IsRetrograde":false},{"TotalDegree":3.5083333333333333,"Name":"Pallas","IsRetrograde":false}]},{"type":"Conjunction","fromDeg":239.5,"toDeg":236.825,"celestialBodies":[{"TotalDegree":239.5,"Name":"MeanNode","IsRetrograde":true},{"TotalDegree":236.825,"Name":"Moon","IsRetrograde":false}]},{"type":"Conjunction","fromDeg":239.5,"toDeg":240.8,"celestialBodies":[{"TotalDegree":239.5,"Name":"MeanNode","IsRetrograde":true},{"TotalDegree":240.8,"Name":"TrueNode","IsRetrograde":false}]},{"type":"Trine","fromDeg":239.5,"toDeg":356.51666666666665,"celestialBodies":[{"TotalDegree":239.5,"Name":"MeanNode","IsRetrograde":true},{"TotalDegree":356.51666666666665,"Name":"Vesta","IsRetrograde":false}]},{"type":"Conjunction","fromDeg":240.8,"toDeg":236.825,"celestialBodies":[{"TotalDegree":240.8,"Name":"TrueNode","IsRetrograde":false},{"TotalDegree":236.825,"Name":"Moon","IsRetrograde":false}]},{"type":"Conjunction","fromDeg":240.8,"toDeg":239.5,"celestialBodies":[{"TotalDegree":240.8,"Name":"TrueNode","IsRetrograde":false},{"TotalDegree":239.5,"Name":"MeanNode","IsRetrograde":true}]},{"type":"Trine","fromDeg":240.8,"toDeg":356.51666666666665,"celestialBodies":[{"TotalDegree":240.8,"Name":"TrueNode","IsRetrograde":false},{"TotalDegree":356.51666666666665,"Name":"Vesta","IsRetrograde":false}]},{"type":"Sextile","fromDeg":27.40833333333333,"toDeg":89.08333333333333,"celestialBodies":[{"TotalDegree":27.40833333333333,"Name":"Chiron","IsRetrograde":false},{"TotalDegree":89.08333333333333,"Name":"Sun","IsRetrograde":false}]},{"type":"Conjunction","fromDeg":27.40833333333333,"toDeg":22.758333333333333,"celestialBodies":[{"TotalDegree":27.40833333333333,"Name":"Chiron","IsRetrograde":false},{"TotalDegree":22.758333333333333,"Name":"Mars","IsRetrograde":false}]},{"type":"Opposition","fromDeg":27.40833333333333,"toDeg":208.5,"celestialBodies":[{"TotalDegree":27.40833333333333,"Name":"Chiron","IsRetrograde":false},{"TotalDegree":208.5,"Name":"Uranus","IsRetrograde":true}]},{"type":"Sextile","fromDeg":27.40833333333333,"toDeg":87.14999999999999,"celestialBodies":[{"TotalDegree":27.40833333333333,"Name":"Chiron","IsRetrograde":false},{"TotalDegree":87.14999999999999,"Name":"Juno","IsRetrograde":false}]},{"type":"Sextile","fromDeg":134.475,"toDeg":75.09166666666667,"celestialBodies":[{"TotalDegree":134.475,"Name":"Vertex","IsRetrograde":false},{"TotalDegree":75.09166666666667,"Name":"Mercury","IsRetrograde":true}]},{"type":"Conjunction","fromDeg":134.475,"toDeg":134.475,"celestialBodies":[{"TotalDegree":134.475,"Name":"Vertex","IsRetrograde":false},{"TotalDegree":134.475,"Name":"Venus","IsRetrograde":false}]},{"type":"Trine","fromDeg":134.475,"toDeg":20.208333333333332,"celestialBodies":[{"TotalDegree":134.475,"Name":"Vertex","IsRetrograde":false},{"TotalDegree":20.208333333333332,"Name":"Jupiter","IsRetrograde":false}]},{"type":"Trine","fromDeg":134.475,"toDeg":249.9,"celestialBodies":[{"TotalDegree":134.475,"Name":"Vertex","IsRetrograde":false},{"TotalDegree":249.9,"Name":"Neptune","IsRetrograde":true}]},{"type":"Square","fromDeg":134.475,"toDeg":48.13333333333333,"celestialBodies":[{"TotalDegree":134.475,"Name":"Vertex","IsRetrograde":false},{"TotalDegree":48.13333333333333,"Name":"Ceres","IsRetrograde":false}]},{"type":"Square","fromDeg":48.13333333333333,"toDeg":134.475,"celestialBodies":[{"TotalDegree":48.13333333333333,"Name":"Ceres","IsRetrograde":false},{"TotalDegree":134.475,"Name":"Venus","IsRetrograde":false}]},{"type":"Sextile","fromDeg":48.13333333333333,"toDeg":109.40833333333333,"celestialBodies":[{"TotalDegree":48.13333333333333,"Name":"Ceres","IsRetrograde":false},{"TotalDegree":109.40833333333333,"Name":"Saturn","IsRetrograde":false}]},{"type":"Square","fromDeg":48.13333333333333,"toDeg":134.475,"celestialBodies":[{"TotalDegree":48.13333333333333,"Name":"Ceres","IsRetrograde":false},{"TotalDegree":134.475,"Name":"Vertex","IsRetrograde":false}]},{"type":"Square","fromDeg":3.5083333333333333,"toDeg":89.08333333333333,"celestialBodies":[{"TotalDegree":3.5083333333333333,"Name":"Pallas","IsRetrograde":false},{"TotalDegree":89.08333333333333,"Name":"Sun","IsRetrograde":false}]},{"type":"Opposition","fromDeg":3.5083333333333333,"toDeg":186.5,"celestialBodies":[{"TotalDegree":3.5083333333333333,"Name":"Pallas","IsRetrograde":false},{"TotalDegree":186.5,"Name":"Pluto","IsRetrograde":false}]},{"type":"Square","fromDeg":3.5083333333333333,"toDeg":87.14999999999999,"celestialBodies":[{"TotalDegree":3.5083333333333333,"Name":"Pallas","IsRetrograde":false},{"TotalDegree":87.14999999999999,"Name":"Juno","IsRetrograde":false}]},{"type":"Conjunction","fromDeg":87.14999999999999,"toDeg":89.08333333333333,"celestialBodies":[{"TotalDegree":87.14999999999999,"Name":"Juno","IsRetrograde":false},{"TotalDegree":89.08333333333333,"Name":"Sun","IsRetrograde":false}]},{"type":"Sextile","fromDeg":87.14999999999999,"toDeg":22.758333333333333,"celestialBodies":[{"TotalDegree":87.14999999999999,"Name":"Juno","IsRetrograde":false},{"TotalDegree":22.758333333333333,"Name":"Mars","IsRetrograde":false}]},{"type":"Trine","fromDeg":87.14999999999999,"toDeg":208.5,"celestialBodies":[{"TotalDegree":87.14999999999999,"Name":"Juno","IsRetrograde":false},{"TotalDegree":208.5,"Name":"Uranus","IsRetrograde":true}]},{"type":"Sextile","fromDeg":87.14999999999999,"toDeg":27.40833333333333,"celestialBodies":[{"TotalDegree":87.14999999999999,"Name":"Juno","IsRetrograde":false},{"TotalDegree":27.40833333333333,"Name":"Chiron","IsRetrograde":false}]},{"type":"Square","fromDeg":87.14999999999999,"toDeg":3.5083333333333333,"celestialBodies":[{"TotalDegree":87.14999999999999,"Name":"Juno","IsRetrograde":false},{"TotalDegree":3.5083333333333333,"Name":"Pallas","IsRetrograde":false}]},{"type":"Trine","fromDeg":356.51666666666665,"toDeg":236.825,"celestialBodies":[{"TotalDegree":356.51666666666665,"Name":"Vesta","IsRetrograde":false},{"TotalDegree":236.825,"Name":"Moon","IsRetrograde":false}]},{"type":"Trine","fromDeg":356.51666666666665,"toDeg":239.5,"celestialBodies":[{"TotalDegree":356.51666666666665,"Name":"Vesta","IsRetrograde":false},{"TotalDegree":239.5,"Name":"MeanNode","IsRetrograde":true}]},{"type":"Trine","fromDeg":356.51666666666665,"toDeg":240.8,"celestialBodies":[{"TotalDegree":356.51666666666665,"Name":"Vesta","IsRetrograde":false},{"TotalDegree":240.8,"Name":"TrueNode","IsRetrograde":false}]}],"Casas":[{"House":1,"Sign":{"Name":"Aquarius","StartsAt":300,"EndsAt":330,"Id":10,"Symbol":"k","Element":"a","Mode":"f","Rulers":["Uranus"]},"RelativeDistance":25.98607954272768,"FullDistance":325.9860795427277},{"House":2,"Sign":{"Name":"Pisces","StartsAt":330,"EndsAt":360,"Id":11,"Symbol":"l","Element":"w","Mode":"m","Rulers":["Neptune"]},"RelativeDistance":20.17771096025399,"FullDistance":350.177710960254},{"House":3,"Sign":{"Name":"Aries","StartsAt":0,"EndsAt":30,"Id":0,"Symbol":"a","Element":"f","Mode":"c","Rulers":["Mars"]},"RelativeDistance":18.932533817753566,"FullDistance":18.932533817753566},{"House":4,"Sign":{"Name":"Taurus","StartsAt":30,"EndsAt":60,"Id":1,"Symbol":"b","Element":"e","Mode":"f","Rulers":["Venus"]},"RelativeDistance":21.609774769509045,"FullDistance":51.609774769509045},{"House":5,"Sign":{"Name":"Gemini","StartsAt":60,"EndsAt":90,"Id":2,"Symbol":"c","Element":"a","Mode":"m","Rulers":["Mercury"]},"RelativeDistance":25.373988073379167,"FullDistance":85.37398807337917},{"House":6,"Sign":{"Name":"Cancer","StartsAt":90,"EndsAt":120,"Id":3,"Symbol":"d","Element":"w","Mode":"c","Rulers":["Moon"]},"RelativeDistance":27.204418942190557,"FullDistance":117.20441894219056},{"House":7,"Sign":{"Name":"Leo","StartsAt":120,"EndsAt":150,"Id":4,"Symbol":"e","Element":"f","Mode":"f","Rulers":["Sun"]},"RelativeDistance":25.98607954272768,"FullDistance":145.98607954272768},{"House":8,"Sign":{"Name":"Virgo","StartsAt":150,"EndsAt":180,"Id":5,"Symbol":"f","Element":"e","Mode":"m","Rulers":["Mercury"]},"RelativeDistance":20.17771096025399,"FullDistance":170.177710960254},{"House":9,"Sign":{"Name":"Libra","StartsAt":180,"EndsAt":210,"Id":6,"Symbol":"g","Element":"a","Mode":"c","Rulers":["Venus"]},"RelativeDistance":18.93253381775355,"FullDistance":198.93253381775355},{"House":10,"Sign":{"Name":"Scorpio","StartsAt":210,"EndsAt":240,"Id":7,"Symbol":"h","Element":"w","Mode":"f","Rulers":["Pluto"]},"RelativeDistance":21.609774769509045,"FullDistance":231.60977476950904},{"House":11,"Sign":{"Name":"Sagittarius","StartsAt":240,"EndsAt":270,"Id":8,"Symbol":"i","Element":"f","Mode":"m","Rulers":["Jupiter"]},"RelativeDistance":25.373988073379167,"FullDistance":265.37398807337917},{"House":12,"Sign":{"Name":"Capricorn","StartsAt":270,"EndsAt":300,"Id":9,"Symbol":"j","Element":"e","Mode":"c","Rulers":["Saturn"]},"RelativeDistance":27.204418942190557,"FullDistance":297.20441894219056}]}}'
        setJson(json)
    }
    function setJson(j){
        repH.model=1
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

        //Ceres
        console.log("jsonHades:"+json.jsonHades.Cuerpos.CelestialBodies[14].Name)
        //Phalas
        console.log("jsonHades:"+json.jsonHades.Cuerpos.CelestialBodies[15].Name)
        //Juno
        console.log("jsonHades:"+json.jsonHades.Cuerpos.CelestialBodies[16].Name)
        //Vesta
        console.log("jsonHades:"+json.jsonHades.Cuerpos.CelestialBodies[17].Name)


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
        let vRNodoPS=30*getSigIndex(json.psc.s.s)
        let vRNodoPN=30*getSigIndex(json.psc.n.s)

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


        console.log('Selena TotalDegree: '+json.jsonHades.Cuerpos.CelestialBodies[14].TotalDegree)
        console.log('Selena TotalDegree Conv: '+r.convertToDms(json.jsonHades.Cuerpos.CelestialBodies[14].TotalDegree))
        let gms=r.convertToDms(json.jsonHades.Cuerpos.CelestialBodies[14].TotalDegree).split('|')
        let td=parseInt(json.jsonHades.Cuerpos.CelestialBodies[14].TotalDegree)
        let indexSign=getIndexFromDecimalDeggre(td)
        console.log('Selena House indexSign: '+indexSign)//)[0].FullDistance)
        console.log('Selena House: '+getHouse(td, json.jsonHades.Casas))//)[0].FullDistance)

        jo=json.psc.selena
        xSelena.rotation=r.sigRot-parseInt(json.jsonHades.Cuerpos.CelestialBodies[14].TotalDegree)//0-vRSelena+r.sigRot-jo.g
        o={}
        o.p=objSigns[indexSign]//objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=indexSign
        o.g=td>29?parseInt(td-indexSign*30):td//jo.g
        o.m=gms[1]//jo.m
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

        jo=json.psc.s
        xNodoPS.rotation=0-vRNodoPS+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xNodoPS.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        jo=json.psc.n
        xNodoPN.rotation=0-vRNodoPN+r.sigRot-jo.g
        o={}
        o.p=objSigns[objSignsNames.indexOf(jo.s)]
        o.ns=objSignsNames.indexOf(jo.s)
        o.g=jo.g
        o.m=jo.m
        o.h=jo.h
        xNodoPN.objData=o
        objSigns[objSignsNames.indexOf(jo.s)]++

        repH.model=12
        console.log('-------------------->>cccccc '+json.params.ciudad)
        cnLoaded(json.params.n, json.params.d, json.params.m, json.params.a, json.params.h, json.params.min, json.params.lon, json.params.lat, json.params.ciudad)
    }
    function getSigIndex(s){
        let ms=['ari', 'tau', 'gem', 'cnc', 'leo', 'vir', 'lib', 'sco', 'sgr', 'cap', 'aqr', 'psc']
        return ms.indexOf(s)
    }
    function convertToDms(dd) {
        var absDd = Math.abs(dd);
        var deg = absDd | 0;
        var frac = absDd - deg;
        var min = (frac * 60) | 0;
        var sec = frac * 3600 - min * 60;
        // Round it to 2 decimal points.
        sec = Math.round(sec * 100) / 100;
        return deg + "|" + min + "|" + sec ;
    }
    function getHouse(dd, json) {
        let sigName0=(''+json[0].Sign.Name).replace('Aquarius', r.objSignsNames[10])
        console.log('getHouse Signo:'+sigName0)
        console.log('getHouse 1:'+dd)
        let ret=0
        let tdh1=json[0].FullDistance
        let tdh2=json[1].FullDistance
        let diff1=360-tdh1
        let diff2=360-tdh2
        let ran1H1=0-diff1
        let ran2H1=0-diff2
        if(dd>0&&dd<tdh1){
            ret=1
        }
        return ret
     }
    function getIndexFromDecimalDeggre(dd) {
        console.log('getIndexFromDecimalDeggre 1:'+dd)
        let ret=0
        let d=parseInt(dd)
        if(d>0&&d<29){
            ret=0
        }else if(d>=30&&d<59){
            ret=1
        }else if(d>=60&&d<89){
            ret=2
        }else if(d>=90&&d<119){
            ret=3
        }else if(d>=120&&d<149){
            ret=4
        }else if(d>=150&&d<179){
            ret=5
        }else if(d>=180&&d<209){
            ret=6
        }else if(d>=210&&d<239){
            ret=7
        }else if(d>=240&&d<269){
            ret=8
        }else if(d>=270&&d<299){
            ret=9
        }else if(d>=300&&d<329){
            ret=10
        }else if(d>=330&&d<359){
            ret=11
        }else{
            ret=0
        }
       console.log('getIndexFromDecimalDeggre 2:'+ret)
        return ret
    }
}
