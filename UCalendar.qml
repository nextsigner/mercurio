import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Calendar{
    id: r
    anchors.fill: parent
    visible: parent.objectName==='itemCal1'||parent.objectName==='itemCal2'
    property bool setTextInput: false
    property int num:-1
    signal selected(var newDate)
    onVisibleChanged:{
        if(parent.objectName==='itemCal1'){
            num=1
            return
        }
        if(parent.objectName==='itemCal2'){
            num=2
            return
        }
        num=-1
    }
    style: CalendarStyle {
        dayDelegate: Rectangle{
            color: styleData.selected ? app.c2 : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
            Label {
                text: styleData.date.getDate()
                font.pixelSize: app.fs
                anchors.centerIn: parent
                color: styleData.valid ? (styleData.selected ?app.c1:app.c2) : app.c4
            }
            Rectangle {
                width: parent.width
                height: 1
                color: app.c3
                anchors.bottom: parent.bottom
            }
            Rectangle {
                width: 1
                height: parent.height
                color: app.c3
                anchors.right: parent.right
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    r.setTextInput=true
                    r.selectedDate=styleData.date
                }
            }
        }
    }
    onSelectedDateChanged: {
        if(setTextInput){
            var d = selectedDate
            let dia=''+d.getDate()
            let mes=''+parseInt(d.getMonth()+1)
            if(parseInt(dia)<10){
                dia='0'+dia
            }
            if(parseInt(mes)<10){
                mes='0'+mes
            }
            let an=d.getFullYear()
            let s=''+dia+'/'+mes+'/'+an
            //uLogView.showLog('set!'+cal.num)
            r.selected(d)
        }
        setTextInput=true
    }
    Rectangle{
        anchors.fill: parent
        color: app.c1
        z: parent.z-1
    }
    MouseArea{
        anchors.fill: parent
        z: r.z-1
    }
}
