import QtQuick 2.0
import Qt.labs.folderlistmodel 2.12

Item {
    id: r
    width: parent.width
    height: app.height
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
            Component{
                id: compCns
                Rectangle{
                    width: parent.width-app.fs
                    height: app.fs*2
                    color: app.c2
                    radius: app.fs*0.25
                    property var d
                    UText{
                        id: txtFN
                        text: fileName
                        color: app.c1
                        anchors.centerIn: parent
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
                        txtFN.text='Carta Natal de '+of+' creada el '+s

                    }
                }
            }
        }
    }
}
