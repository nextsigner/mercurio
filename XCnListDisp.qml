import QtQuick 2.0
import Qt.labs.folderlistmodel 2.12

Item {
    id: r
    width: parent.width
    height: app.height
    property string cFileName: ''
    FolderListModel{
        id: flmCns
        folder: './cns'
    }
    Column{
        spacing: app.fs*0.5
        anchors.horizontalCenter: parent.horizontalCenter
        UText{
            text: '<b>Cartas Disponibles</b>'
        }
        ListView{
            id: lvCns
            width: r.width
            height: r.height
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
                        let s2=' Nacido a las '+json.params.h+':'+json.params.min+' '
                        txtFN.text=''+of+' '+s2+' creada el '+s

                    }
                }
            }
        }
    }
}
