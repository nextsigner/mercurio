import QtQuick 2.12
import QtQuick.Controls 2.12
import Qt.labs.settings 1.0
import "func.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    property alias xcn: cn
    Settings{
        id: sCnView
        fileName: pws+'/'+app.moduleName+'/scnview'
        property real zoom: 1.0
    }
    Flickable{
        //anchors.fill: r
        id: flCn
        width: cn.width
        height: cn.height
        anchors.centerIn: r
        contentWidth: cn.width*1.5
        contentHeight: cn.height*1.5
        contentX: ((r.width-cn.width)*0.5)*0.75
        contentY: ((r.height-cn.height)*0.5)*0.75
        XCn{
            id: cn
            width: r.width*sCnView.zoom//*0.25
            anchors.centerIn: parent
            onDoubleClick: {
                if(sCnView.zoom>3||cn.width>r.width*0.8){
                    sCnView.zoom-=0.1
                }else{
                    sCnView.zoom=2
                }
                flCn.contentWidth=r.width*sCnView.zoom*1.25
                flCn.contentHeight=r.width*sCnView.zoom*1.25
                flCn.contentX=((r.width-cn.width)*0.5)*0.75
                flCn.contentY=((r.height-cn.height)*0.5)*0.75
            }
        }
    }
    BotonUX{
        text: 'atras'
        onClicked: r.visible=false
    }
    //    Text{
//        text: 'Z:'+parseFloat(sCnView.zoom).toFixed(2)+' x:'+flCn.contentX
//        font.pixelSize: 30
//        color: 'red'
//    }
    //Component.onCompleted: sCnView.zoom=1


}
