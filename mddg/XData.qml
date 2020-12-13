import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: r
    anchors.fill: parent
    property bool desplegado: cbPlanetas.currentIndex!==0
    Flickable{
        id: flick
        anchors.fill: r
        contentWidth: r.width
        contentHeight: col1.height+app.fs*4
        Column{
            id: col1
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: app.fs*2
            ComboBox{
                id: cbPlanetas
                font.pixelSize: app.fs*2
                anchors.horizontalCenter: parent.horizontalCenter
                model: app.planetas
                onCurrentIndexChanged: updateData()
                Rectangle{
                    width: parent.width+4
                    height: parent.height+4
                    color: 'transparent'
                    border.width: 3
                    border.color: 'red'
                    //z: parent.z-1
                    anchors.centerIn: parent
                    visible: parent.focus
                }
            }
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: app.fs*2
                visible: cbPlanetas.currentIndex!==0
                onVisibleChanged: {
                    if(!visible){
                        rb1.checked=false
                        rb2.checked=false
                    }
                }
                Row{
                    Text{
                        text: 'Signo'
                        font.pixelSize: app.fs
                        color: app.c2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    RadioButton{
                        id: rb1
                        onCheckedChanged: {
                            if(checked){
                                rb2.checked=false
                            }
                        }
                    }
                }
                Row{
                    Text{
                        text: 'Casa'
                        font.pixelSize: app.fs
                        color: app.c2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    RadioButton{
                        id: rb2
                        onCheckedChanged: {
                            if(checked){
                                rb1.checked=false
                            }
                        }
                    }
                }
            }
            ComboBox{
                id: cbSignos
                font.pixelSize: app.fs*2
                anchors.horizontalCenter: parent.horizontalCenter
                model: app.signos
                visible: rb1.checked
                onCurrentIndexChanged: {
                    r.updateData()
                }
                Rectangle{
                    width: parent.width+4
                    height: parent.height+4
                    color: 'transparent'
                    border.width: 3
                    border.color: 'red'
                    //z: parent.z-1
                    anchors.centerIn: parent
                    visible: parent.focus
                }
            }
            ComboBox{
                id: cbCasas
                font.pixelSize: app.fs*2
                anchors.horizontalCenter: parent.horizontalCenter
                model: ['Seleccionar Casa', '1','2','3','4','5','6','7','8','9','10','11','12']
                visible: rb2.checked
                onCurrentIndexChanged: {
                    r.updateData()
                }
                Rectangle{
                    width: parent.width+4
                    height: parent.height+4
                    color: 'transparent'
                    border.width: 3
                    border.color: 'red'
                    //z: parent.z-1
                    anchors.centerIn: parent
                    visible: parent.focus
                }
            }
            Column{
                id: col2
                width: r.width
                spacing: app.fs*2
            }
        }
    }
    function updateData(){
        for(var i=0;i<col2.children.length;i++){
            col2.children[i].destroy(1)
        }
        flick.contentX=0
        getJSON()
    }
    function setData(json){
        let tipo=cbSignos.visible?'s':'h'
        let num=cbSignos.visible?cbSignos.currentIndex:cbCasas.currentIndex
        let data=json[tipo+''+num]
        if(!data){
            return
        }
        let dataItems=data.split('|')
        for(var i=0;i<dataItems.length;i++){
            let comp=Qt.createComponent('XItemData.qml')
            let obj=comp.createObject(col2, {text:dataItems[i]})
        }
    }
    function getJSON() {
        var request = new XMLHttpRequest()
        request.open('GET', 'file:../data/'+cbPlanetas.currentText+'.json', true);
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status && request.status === 200) {
                    console.log("response", request.responseText)
                    var result = JSON.parse(request.responseText)
                    if(result){
                        setData(result)
                    }
                    //console.log('Data-->'+JSON.stringify(result))
                } else {
                    console.log("HTTP:", request.status, request.statusText)
                }
            }
        }
        request.send()
    }
    function reset(){
        cbSignos.currentIndex=0
        cbCasas.currentIndex=0
        rb1.checked=false
        rb2.checked=false
        updateData()
        cbPlanetas.currentIndex=0
        cbPlanetas.focus=true
    }
    function a1(){
        rb1.checked=false
        rb2.checked=false
        cbPlanetas.focus=true
        updateData()
    }
    function a2(){
        rb1.checked=true
        cbSignos.focus=true
        updateData()
    }
    function a3(){
        rb2.checked=true
        cbCasas.focus=true
        updateData()
    }
}
