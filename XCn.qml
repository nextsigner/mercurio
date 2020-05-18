
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
    property var arrayElementsColors: ['red', 'brown', '#16E9F6', '#118CC8']
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
        Repeater{
            id: rep
            model: 12
            Item{
                width: parent.width
                height: 3
                anchors.centerIn: parent
                rotation: 0-index*30
                property color c: index===0?'gray':'green'
                Repeater{
                    id: repG
                    model: 30
                    Rectangle{
                        id: xG
                        width: parent.width
                        height: 3
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
                        rotation: index*30+15
                        visible: false
                    }
                    ColorOverlay{
                        source: iconoSig
                        anchors.fill: iconoSig
                        color: 'red'
                        rotation: iconoSig.rotation
                        Component.onCompleted: {
                            if(index===0||index===4||index===8){
                                color='white'
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
    Rectangle{
        id: bg2
        width: r.width*0.2
        height: width
        radius: width*0.5
        border.width: 1
        border.color: r.borderColor
        color: r.color
        anchors.centerIn: r
    }

    function setJson(){

    }
}
