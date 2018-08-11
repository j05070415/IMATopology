import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

ToolBar {
    RowLayout {
        anchors.fill: parent
        ToolButton {
            iconSource: "qrc:/images/open.png"
        }
        ToolButton {
            iconSource: "qrc:/images/save.png"
        }
        ToolButton {
            iconSource: "qrc:/images/save_as.png"
        }
        Item { Layout.fillWidth: true }
    }
}
