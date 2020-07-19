import QtQuick 2.0
import Qt.labs.folderlistmodel 2.12

Item {
    id: r
    width: parent.width
    height: app.height
    onVisibleChanged: lvCns.focus=visible
    property var container
    property string cFileName: ''
    FolderListModel{
        id: flmCns
        folder: './cns'
    }
    Column{
        spacing: app.fs*0.5
        anchors.horizontalCenter: parent.horizontalCenter
        Flow{
            id: flowCnListDisp
            width:r.width-app.fs
            spacing: app.fs*0.5
            BotonUX{
                text: 'Atras'
                fontSize: Qt.platform.os==='android'?(app.rot?app.fs*0.5:app.fs):app.fs
                onClicked: {
                    unik.speak('atras')
                    r.container.mod=0
                }
            }
            BotonUX{
                text: 'Ver'
                visible: r.container.mod===1&&xCnListDisp.cFileName!==''
                onClicked: {
                    xCnView.currentImgUrl=app.serverUrl+':'+app.portFiles+'/files/'+xCnListDisp.cFileName.replace('.json', '')+'.png'
                    xCnView.xcn.setJson(unik.getFile('./cns/'+xCnListDisp.cFileName))
                    xCnListDisp.cFileName=''
                    xCnView.visible=true
                    r.container.mod=0
                }
            }
            BotonUX{
                visible: xCnListDisp.cFileName!==''
                text: 'Eliminar'
                onClicked: {
                    unik.deleteFile('./cns/'+xCnListDisp.cFileName)
                    xCnListDisp.cFileName=''
                }
            }
        }
        UText{
            id:txtTit
            text: '<b>Cartas Disponibles '+flmCns.count+'</b>'
        }
        ListView{
            id: lvCns
            width: r.width
            height: r.height-flowCnListDisp.height-txtTit.height-app.fs
            model: flmCns
            delegate: compCns
            spacing: app.fs*0.25
            clip: true
            Component{
                id: compCns
                Rectangle{
                    id: xItemCnFile
                    width: parent.width-app.fs
                    height: txtFN.contentHeight+app.fs
                    color: r.cFileName===fileName?app.c2:app.c1
                    border.width: 2
                    border.color: r.cFileName===fileName?app.c1:app.c2
                    radius: app.fs*0.25
                    property var d
                    MouseArea{
                        anchors.fill: parent
                        onClicked: r.cFileName=fileName
                        onDoubleClicked: {
                            r.cFileName=fileName
                            xCnView.currentImgUrl=app.serverUrl+':'+app.portFiles+'/files/'+xCnListDisp.cFileName.replace('.json', '')+'.png'
                            xCnView.xcn.setJson(unik.getFile('./cns/'+xCnListDisp.cFileName))
                            xCnListDisp.cFileName=''
                            xCnView.visible=true
                            r.container.mod=0
                        }
                    }
                    Row{
                        spacing: app.fs*0.5
                        anchors.centerIn: parent
                        UText{
                            id: txtFN
                            text: fileName
                            width: xItemCnFile.width-app.fs
                            color: r.cFileName===fileName?app.c1:app.c2
                            anchors.verticalCenter: parent.verticalCenter
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    Component.onCompleted: {
                        let m0=fileName.split('_')
                        if(fileName.indexOf('.json')!==fileName.length-5||m0.length<=1){
                            height=0
                            visible=false
                            return
                        }
                        d = new Date(parseInt(m0[0]))
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
                        let of=''
                        for(var i=1;i<m0.length;i++){
                            of+=m0[i].replace('.json', '')
                        }
                        let jsonData=unik.getFile('./cns/'+fileName)
                        let json=JSON.parse(jsonData)
                        //let s2=''//' Nacido a las '+json.params.h+':'+json.params.min+' '
                        txtFN.text=''+of+' creada el '+s
                    }
                }
            }
        }
    }
}
