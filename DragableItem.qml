import QtQuick 2.8
import QtQml.Models 2.2

Item {
    id: root
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: draggable
        onClicked: print("fafafds")
    }

    Item {
        id: draggable
        anchors.fill: parent
        Drag.active: mouseArea.drag.active
        Drag.hotSpot.x: 0
        Drag.hotSpot.y: 0
        Drag.mimeData: { "text/plain": type}
        Drag.dragType: Drag.Automatic
    } // Item
}
