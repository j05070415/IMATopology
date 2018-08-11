import QtQuick 2.8
import QtQuick.Controls 1.4

ListView {
    id: root
    interactive: false
    model: ListModel {}
    Component.onCompleted: {
        model.append({"image":"qrc:/images/sw.png", "name": "交换机", "type":"sw"})
        model.append({"image":"qrc:/images/es.png", "name": "终端", "type":"es"})
    }

    delegate: DragableItem {
        width: root.width
        height: 40
        Row {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 3
            Image {
                sourceSize.width: 40
                sourceSize.height: 40
                source: image
            }
            Label {
                anchors.verticalCenter: parent.verticalCenter
                text: name
            }
        }
        Rectangle {
            width: parent.width
            anchors.bottom: parent.bottom
            height: 1
            color: "grey"
        }
    }
}
