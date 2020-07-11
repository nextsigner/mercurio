import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Calendar{
    id: r
    anchors.fill: parent
    visible: parent.objectName==='itemCal1'||parent.objectName==='itemCal2'
    property bool setTextInput: false
    property int num:-1
    property int currentYear: r.selectedDate.getFullYear()
    property int currentMonth: r.selectedDate.getMonth()+1
    property int currentDay: r.selectedDate.getDate()
    property var monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiempre', 'Octubre', 'Noviembre', 'Diciembre']
    property string monthString: 'Mes N°'
    property int widthBtns:  Qt.platform.os!=='android'?app.fs*1.2:app.fs*2
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
        id: uCalendarStyle
        navigationBar: Rectangle{
            width: r.width-2
            height: r.widthBtns*4
            color: app.c1
            anchors.centerIn: parent
            Column{
                spacing: app.fs
                anchors.centerIn: parent
                Row{
                    spacing: app.fs
                    anchors.horizontalCenter: parent.horizontalCenter
                    BotonUX{
                        text: '-10'
                        width: app.fs*2
                        height: r.widthBtns
                        onClicked: {
                            setTextInput=false
                            var fecha = r.selectedDate;
                            fecha.setYear(fecha.getFullYear() - 10);
                            r.selectedDate=fecha
                        }
                    }
                    BotonUX{
                        text: '-1'
                        width: app.fs*2
                        height: r.widthBtns
                        onClicked: {
                            setTextInput=false
                            var fecha = r.selectedDate;
                            fecha.setYear(fecha.getFullYear() - 1);
                            r.selectedDate=fecha
                        }
                    }
                    Text{
                        text: r.currentYear
                        font.pixelSize: app.fs
                        color: app.c2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    BotonUX{
                        text: '+1'
                        width: app.fs*2
                        height: r.widthBtns
                        onClicked: {
                            setTextInput=false
                            var fecha = r.selectedDate;
                            fecha.setYear(fecha.getFullYear() + 1);
                            r.selectedDate=fecha
                        }
                    }
                    BotonUX{
                        text: '+10'
                        width: app.fs*2
                        height: r.widthBtns
                        onClicked: {
                            setTextInput=false
                            var fecha = r.selectedDate;
                            fecha.setYear(fecha.getFullYear() + 10);
                            r.selectedDate=fecha
                        }
                    }
                }
                Row{
                    spacing: app.fs
                    anchors.horizontalCenter: parent.horizontalCenter
                    BotonUX{
                        text: '<'
                        width: r.widthBtns
                        height: width
                        onClicked: {
                            setTextInput=false
                            var fecha = r.selectedDate;
                            fecha.setMonth(fecha.getMonth() - 1);
                            r.selectedDate=fecha
                        }
                    }
                    Text{
                        text: r.monthString+' '+r.currentMonth+' - '+r.monthNames[r.currentMonth - 1]
                        font.pixelSize: app.fs
                        color: app.c2
                        width: r.width*0.6
                        horizontalAlignment: Text.AlignHCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    BotonUX{
                        text: '>'
                        width: r.widthBtns
                        height: width
                        onClicked: {
                            setTextInput=false
                            var fecha = r.selectedDate;
                            fecha.setMonth(fecha.getMonth() + 1);
                            r.selectedDate=fecha
                        }
                    }
                }
            }
        }
        dayOfWeekDelegate: Rectangle{
            width: r.width
            height: app.fs*4
            color: app.c1
            border.width: 1
            border.color: app.c2
            Label {
                id: l1
                text:control.__locale.dayName(styleData.dayOfWeek, control.dayOfWeekFormat)
                font.pixelSize: app.fs
                anchors.centerIn: parent
                color: app.c2
            }
            Item{
                visible: styleData.dayOfWeek===1
                anchors.verticalCenter: l1.verticalCenter
                anchors.right: parent.left
                //anchors.rightMargin: parent.width-l1.width
                width: parent.width
                height: parent.height
                Label {
                    text: unikSettings.lang==='es'?'dom.':'sun.'
                    font.pixelSize: app.fs
                    color: app.c2
                    anchors.centerIn: parent
                }
            }
            Rectangle {
                width: parent.width
                height: 1
                color: app.c3
                anchors.bottom: parent.bottom
            }
        }
        dayDelegate: Rectangle{
            id: xDayDelegate
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
                    r.visible=false
                }
            }
        }
    }
    onSelectedDateChanged: {
        currentYear= r.selectedDate.getFullYear()
        currentMonth= r.selectedDate.getMonth()+1
        currentDay= r.selectedDate.getDate()
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
    Component.onCompleted: {
        if(unikSettings&&unikSettings.lang==='en'){
            r.monthNames=['Junaury', 'Febraury', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'Octber', 'November', 'December']
            r.monthString='Month N° '
        }
    }
    BotonUX{
        text: 'X'
        width: app.fs*2
        height: r.widthBtns
        anchors.right: parent.right
        anchors.rightMargin: r.widthBtns*0.25
        anchors.top: parent.top
        anchors.topMargin: r.widthBtns*0.25
        onClicked: {
            r.visible=false
        }
    }
}
