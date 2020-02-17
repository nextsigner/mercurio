import QtQuick 2.0
Rectangle {
    id: r
    width: a.contentWidth+(r.fontSize*2*(unikSettings.padding*2))+(unikSettings.borderWidth*2)+app.fs+padding
    height: a.contentHeight+(r.fontSize*2*(unikSettings.padding*2))+(unikSettings.borderWidth*2)+app.fs+padding
    opacity: enabled?1.0:0.5
    objectName: 'sin_nombre'
    color: 'transparent'
    radius: unikSettings.radius
    border.color: xR1.border.color
    border.width: 0
    antialiasing: true
    property var settingObj
    property int padding: 0
    property int fontSize: app.fs
    property bool canceled: false
    property alias text: a.text
    property string t2
    property color backgroudColor: app.c1
    property color fontColor: app.c2
    property string fontFamily: 'Arial'
    property var objToRunQml
    property string qmlCode:''
    property int speed: 100
    property alias touchEnabled: maBX.enabled
    property alias pressed: maBX.p
    property alias bg: xR1
    signal clicked

    Rectangle{
        id: xR1
        color: 'transparent'
        border.width: unikSettings.borderWidth
        border.color: app.c3//r.fontColor
        radius: r.radius//unikSettings.radius
        width: parent.width
        height: parent.height
        anchors.centerIn: r
        antialiasing: true
        Rectangle{
            id: b3
            opacity: b1.opacity!==0.5?1.0:0.0
            width: parent.width
            height: parent.height
            radius: r.radius
            visible: false
            anchors.centerIn: parent
            color: app.c2
            antialiasing: true
            Behavior on opacity{NumberAnimation{duration:r.speed}}
        }
        Rectangle{
            id: b1
            //width: xR1.height
            //height: xR1.width
            width: xR1.width
            height: xR1.height
            radius: r.radius
            rotation: -180
            anchors.centerIn: parent
            opacity: 0.5
            antialiasing: true
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color:'transparent';
                }
                GradientStop {
                    position: 1.00;
                    color: r.fontColor;
                }
            }
            Behavior on opacity{NumberAnimation{duration:r.speed*5}}
        }
        Rectangle{
            id: b2
            opacity: 0.5-b1.opacity
            width: xR1.width
            height: xR1.height
            radius: r.radius
            //rotation: 90//-270
            //visible: false
            antialiasing: true
            onOpacityChanged: {
                if(opacity>=0.5&&!maBX.p){
                    b1.opacity=0.5
                }
            }
            anchors.centerIn: parent
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color:'transparent';
                }
                GradientStop {
                    position: 1.00;
                    color: r.fontColor;
                }
            }
        }
    }
    UText {
        id: a
        font.pixelSize: r.fontSize
        font.family: r.fontFamily
        color: r.fontColor
        anchors.centerIn: parent
        //visible: r.enabled
    }
    UText {
        id: a2
        text:a.text
        font.pixelSize: r.fontSize
        font.family: r.fontFamily
        color: r.backgroudColor
        x: !maBX.p?a.x:a.x+2
        y:a.y
        visible: r.enabled
        Behavior on x{NumberAnimation{duration:200}}
        opacity: b3.opacity
    }

    Rectangle{
        id: xBg1
        z:xR1.z-1
        color: app.c1
        border.width: unikSettings.borderWidth
        border.color: r.fontColor
        radius: xR1.radius
        width: xR1.width
        height: xR1.height
        anchors.centerIn: r
        antialiasing: true
        opacity: 0.5
    }
    MouseArea{
        id: maBX
        anchors.fill: r
        property bool p: false
        onPChanged: {
            if(p){
                if(r.qmlCode===''&&!r.canceled){
                    tBxCancel.stop()
                    return
                };
                tBxCancel.restart()}
        }
        onPressed: {
            p=true
            b1.opacity=0.0
            tBxCancel.restart()
        }
        onReleased: {
            p=false
            b1.opacity=0.5            
        }
        onClicked: {
            tBxCancel.stop()
            p=true
            b1.opacity=0.5
            if(r.qmlCode===''){
                r.clicked()
                return
            }
            run.start()
        }
    }
    Timer{
        id: run
        interval: r.speed*10
        onTriggered: {
            tBxCancel.stop()
            tBxEnable.start()
            r.clicked()
            if(r.canceled){return}
            r.runQml(qmlCode)
        }
    }
    Timer{
        id: tBxCancel
        interval: 3000
        onTriggered: {
            r.canceled=true
            r.enabled=false;
            maBX.p=false
            b1.opacity=0.5
            tBxEnable.start();
        }
    }
    Timer{
        id: tBxEnable
        interval: 2000
        onTriggered: {
            r.canceled=false
            r.enabled=true
        }
    }
    function run(){
        r.clicked()
    }
    function runQml(q){
        var obj = Qt.createQmlObject(q, objToRunQml, 'botonUx-'+r.objectName)
    }
}
