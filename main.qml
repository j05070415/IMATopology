import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1

import QuickQanava 2.0 as Qan
import "qrc:/QuickQanava" as Qan

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Qan.GraphView {
        id: graphView
        anchors.fill: parent
        graph: topology
        navigable: true
        resizeHandlerColor: Material.accent
        gridThickColor: Material.theme === Material.Dark ? "#4e4e4e" : "#c1c1c1"

        Qan.FaceGraph {
            id: topology
            objectName: "graph"
            anchors.fill: parent
            clip: true
            connectorEnabled: true
            selectionColor: Material.accent
            connectorColor: Material.accent
            connectorEdgeColor: Material.accent


            Component.onCompleted: {
                var bw1 = topology.insertFaceNode()
                bw1.image = "qrc:/images/sw.png"
                bw1.item.x = 150
                bw1.item.y = 55
                bw1 = topology.insertFaceNode()
                bw1.image = "qrc:/images/es.png"
                bw1.item.x = 250
                bw1.item.y = 155

                print(topology.nodes.at(0).image)
            }
        }
    }
}
