import QtQuick 2.12
import QtQuick.Controls 2.12
import "func.js" as JS

Rectangle {
    id: r
    width: parent.width
    height: parent.height
    color: app.c1
    XCn{
        id: cn
        anchors.centerIn: r
        width: r.width*0.8
    }
}
