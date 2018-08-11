import QtQuick 2.8
import QtQuick.Controls 1.4
import TreeModel 1.0

TreeView{
    id: root
    model:  TreeModel { }
    itemDelegate: Row {
        height: 27
        Image {
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: 25
            sourceSize.height: 25
            source: {
                styleData.index.model.data(styleData.index, 1000)
            }
        }
        Label {
            anchors.verticalCenter: parent.verticalCenter
            text: {
                styleData.value
            }
        }
    }

    function appendNode(text, type) {
        var swindex = model.index(0, 0, model.index(0, 0))
        var esindex = model.index(1, 0, model.index(0, 0))
        if (type === "sw") {
            append(text, "", swindex)
        } else if (type === "es") {
            append(text, "", esindex)
        }

        tree.expand(swindex)
        tree.expand(esindex)
    }

    function append(text, icon, parent) {
        var count = model.rowCount(parent)
        model.insertRows(count, 1, parent)
        var index = model.index(count, 0, parent)
        model.setData(index, text)
        model.setData(index, icon, 1000)
        return index
    }

    Component.onCompleted: {
        var index = append("节点管理", "", model.index(-1, -1))
        append("交换机", "qrc:/images/sw.png", index)
        append("终端", "qrc:/images/es.png", index)

        root.expand(index)
    }

    TableViewColumn {
        title: "名称"
        role: "display"
        width: 300
    }
}
