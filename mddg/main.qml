import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import Qt.labs.settings 1.0

ApplicationWindow {
        id: app
        visible: true
        width: Screen.width*0.2
        height: Screen.height*0.8
        title: 'Mercurio Data Desktop Gadget'
        color: c1
        property string moduleName: 'mddg'//Mercurio Data Desktop Gadget
        property int fs: width*0.05
        property color c1: 'black'
        property color c2: 'white'
        property color c3: 'red'
        property color c4: 'green'

        property var planetas: ['seleccionar','neptuno']
        property var signos: ['seleccionar','aries', 'tauro','geminis', 'cancer', 'leo', 'virgo','libra', 'escorpio', 'sagitario', 'capricornio', 'acuario', 'piscis']

        Settings{
            id: apps
            fileName: app.moduleName+'.cfg'
            property int fs: 14
        }
        Item{
            id: xApp
            anchors.fill: parent
            XData{id: xData}
        }
        Shortcut{
            sequence: 'Esc'
            onActivated: Qt.quit()
        }

        Shortcut{
            sequence: 'Up'
            onActivated: xData.up()
        }
        Shortcut{
            sequence: '1'
            onActivated: xData.a1()
        }
        Shortcut{
            sequence: 'Left'
            onActivated: xData.a2()
        }
        Shortcut{
            sequence: '2'
            onActivated: xData.a2()
        }
        Shortcut{
            sequence: 'Right'
            onActivated: xData.a3()
        }
        Shortcut{
            sequence: '3'
            onActivated: xData.a3()
        }
        Shortcut{
            sequence: 'Ctrl++'
            onActivated: {
                if(apps.fs<100)apps.fs++
            }
        }
        Shortcut{
            sequence: 'Ctrl+-'
            onActivated: {
                if(apps.fs>10)apps.fs--
            }
        }
        Component.onCompleted: {
            if(Qt.platform.os==='linux'){
                app.x=Screen.width-app.width
            }
            xData.a1()
        }
}
