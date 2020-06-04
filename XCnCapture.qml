
import QtQuick 2.0

Rectangle {
    id: r
    width: app.width*0.5
    height: width
    color: app.c1
    antialiasing: true
    property int fs: r.width*0.05
    property string url

    signal doubleClick
    signal posChanged(int px, int py)
    signal imageLoaded
    onUrlChanged: tReload.start()
    Image {
        id: cnImage
        source: r.url
        width: 5120
        height: 2880
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        property int v: 0
        onStatusChanged: {
            if(cnImage.status===Image.Ready){
                imageLoaded()
            }
            if(cnImage.status===Image.Loading){
                tReload.stop()
            }

            if(cnImage.status===Image.Error){
                tReload.start()
            }
        }
    }
    Timer{
        id: tReload
        running: true
        repeat: true
        interval: 2000
        onTriggered: {
            cnImage.source=r.url+'?r='+cnImage.v
            cnImage.v++
        }
    }
}
