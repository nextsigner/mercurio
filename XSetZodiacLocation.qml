import QtQuick 2.0

Item {
    id: r
    anchors.fill: parent
    Rectangle{
        anchors.fill: r
        color: app.c1
        opacity: 0.65
        MouseArea{anchors.fill: r}
    }
    Rectangle{
        width: r.width-app.fs
        height: colZL.height+app.fs*2
        anchors.centerIn: parent
        color: app.c1
        radius: app.fs
        border.width: unikSettings.borderWidth
        border.color: app.c2
        Column{
            id: colZL
            spacing: app.fs*0.5
            anchors.centerIn: parent
            UText{
                text: unikSettings.lan==='es'?'<b>Ubicación de Zodiac</b>':'<b>Zodiac Location</b>'
            }
            UTextInput{
                id: tiZL
                label: ''
                width:r.width-app.fs*2
                KeyNavigation.tab: tiDia
                //regularExp: RegExpValidator{regExp:  /^([A-Za-zÁÉÍÓÚñáéíóúÑ0-9]+[\s])+([A-Za-zÁÉÍÓÚñáéíóúÑ0-9])/}
                //maximumLength: 50
            }
            BotonUX{
                id: btnSetZL
                text: 'Listo'
                anchors.right: parent.right
                //anchors.verticalCenter: parent.verticalCenter
                opacity: enabled?1.0:0.5
                onClicked: {
                   apps.zodiacLocation=tiZL.text
                    r.destroy(1)
                }
            }
        }
    }
    Timer{
        running: true
        repeat: true
        interval: 250
        onTriggered: {
            btnSetZL.enabled=unik.fileExist(tiZL.text)&&tiZL.text.indexOf('zodiac_server')===tiZL.text.length-13
        }
    }
    Component.onCompleted: {
        tiZL.text=apps.zodiacLocation
    }
}
