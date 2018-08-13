import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1

import QuickQanava 2.0 as Qan
import "qrc:/QuickQanava" as Qan

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    property var switches: []
    property var sw_eses: new Object
    property var es_swes: new Object
    property var sw_swes: new Object
    property var eses: []

    function hasNodes(name) {
        for (var i=0; i<topology.nodes.length; ++i) {
            if (topology.nodes.at(i).label === name)
                return true
        }

        return false
    }

    function findNode(name) {
        for (var i=0; i<topology.nodes.length; ++i) {
            var node = topology.nodes.at(i)
            if (node.label === name)
                return node
        }
    }

    function hasLinkedSw(key, name) {
        var sws = sw_swes[key]
        if (!sws) return false

        for (var i=0; i<sws.length; ++i) {
            var sw = sws[i]
            if (sw === name) return true
        }

        return false
    }

    function readLinjie() {
        var i, j, row, splits, label, tmp
        var linjie = FileOper.read("D:/GitHub/IMATopolgy/linjie.txt")
        var rows = linjie.split("\n")
        for (i=0; i<rows.length; ++i) {
            row = rows[i]
            splits = row.split(" ")
            label = "s"+String(i+1)
            for (j=0; j<splits.length; ++j) {
                var b = splits[j]
                tmp = "s" + String(j+1)
                if (b === "1" && !hasLinkedSw(tmp, label)) {
                    if (!sw_swes[label]) {
                        sw_swes[label] = [tmp]
                    } else {
                        sw_swes[label].push(tmp)
                    }
                }
            }
        }
//        print(JSON.stringify(sw_swes))
    }

    function readTopo() {
        var i, row, splits
        var txt = FileOper.read("D:/GitHub/IMATopolgy/topo.txt")
        var rows = txt.split("\n")
        for (i=0; i<rows.length; ++i) {
            row = rows[i]
            splits = row.split(" ")
            if (splits.length < 2) continue

            var swLabel = "s"+splits[0]
            var node = topology.insertFaceNode({"type":"sw","label":swLabel})
//            var e = topology.insertPort(node, Qan.NodeItem.Right)
            node.image = "qrc:/images/sw.png"
            node.label = swLabel

            switches.push(node)
            var tmps = splits.slice(1)
            tmps = tmps.map(function(id){
                return "e"+id
            })
            sw_eses[swLabel] = tmps
            for (var j=1; j<splits.length; ++j) {
                var esLabel = "e"+splits[j]
                if (!hasNodes(esLabel)) {
                    node = topology.insertFaceNode({"type":"es","label":esLabel})
//                    topology.insertPort(node, Qan.NodeItem.Right)
                    node.image = "qrc:/images/es.png"
                    node.label = esLabel
                    eses.push(node)
                }

                var esSws = es_swes[esLabel]
                if (!esSws) {
                    es_swes[esLabel] = [swLabel]
                } else {
                    es_swes[esLabel].push(swLabel)
                }
            }
        }
    }

    Component.onCompleted: {
        root.showMaximized()
        readLinjie()
        readTopo()
        recalculateSwesPostion()
        recalculateEsesPostion()
        drawLines()
    }

    function drawLines() {
        //sw an es
        var edge
        var keys = Object.keys(sw_eses)
        for (var i=0; i<keys.length; ++i) {
            var key = keys[i]
            var swNode = findNode(key)
            var ess = sw_eses[key]
            for (var j=0; j<ess.length; ++j) {
                var esName = ess[j]
                var esNode = findNode(esName)
                edge = topology.insertEdge(swNode, esNode)
                edge.label = "wedge"+String(i)
//                topology.bindEdgeSource(edge, swNode.item.ports.at(0))
//                topology.bindEdgeDestination(edge, esNode.item.ports.at(0))
            }
        }

        //sw and sw
        keys = Object.keys(sw_swes)
        for (i=0; i<keys.length; ++i) {
            key = keys[i]
            swNode = findNode(key)
            ess = sw_swes[key]
            for (j=0; j<ess.length; ++j) {
                esName = ess[j]
                esNode = findNode(esName)
                edge = topology.insertEdge(swNode, esNode)
                edge.label = "eedge"+String(i)
//                topology.bindEdgeSource(edge, swNode.item.ports.at(0))
//                topology.bindEdgeDestination(edge, esNode.item.ports.at(0))
            }
        }
    }

    function recalculateEsesPostion() {
        var centerX = root.width/2
        var centerY = root.height/2
        var swsize = switches.length
        var perAngle = Math.PI*2/swsize
        var esesKeys = Object.keys(es_swes)
        var radius = 400
        var radius1 = 200
        for (var i=0; i<esesKeys.length; ++i) {
            var k = esesKeys[i]
            var linkedSws = es_swes[k]
            if (linkedSws.length === 0) continue

            var swLabel = linkedSws[0]
            var linkedEss = sw_eses[swLabel]
            if (!linkedEss) continue

            var index = linkedEss.indexOf(k)
            var esnode = findNode(k)
            var swnode = findNode(swLabel)
            var angle = Math.acos((swnode.item.x - centerX)/radius1)
            angle = angle + perAngle/linkedEss.length*index

            esnode.item.x = centerX + Math.cos(angle)*radius
            esnode.item.y = centerY + Math.sin(angle)*radius
        }
    }

    function recalculateSwesPostion() {
        var unit = Math.PI*2/360
        var centerX = root.width/2
        var centerY = root.height/2
        var swsize = switches.length
        var perAngle = Math.PI*2/swsize
        var radius = 200
        for (var i=0; i<swsize; ++i) {
            var node = switches[i]
            node.item.x = centerX + Math.cos(perAngle*i)*radius
            node.item.y = centerY + Math.sin(perAngle*i)*radius
        }
    }

    menuBar: IMAMenuBar {}
    statusBar: StatusBar {}
    toolBar: IMAToolBar {}

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal
        IMATree {
            id: tree
            Layout.fillHeight: true
            Layout.preferredHeight: 249
        }
        Qan.GraphView {
            id: graphView
            clip: true
            Layout.fillHeight: true
            Layout.fillWidth: true
            graph: topology
            navigable: true
            gridThickColor: Material.theme === Material.Dark ? "#4e4e4e" : "#c1c1c1"

            DropArea {
                anchors.fill: parent
                onDropped: {
                    var label = ""
                    var node
                    if (drop.text === "es") {
                        label = "e"+String(eses.length)
                        node = topology.insertFaceNode({"type":"es","label":label})
                        node.label = label
                        node.image = "qrc:/images/es.png"
                    } else if (drop.text === "sw") {
                        label = "s"+String(switches.length)
                        node = topology.insertFaceNode({"type":"sw","label":label})
                        node.label = label
                        node.image = "qrc:/images/sw.png"
                    }
                    topology.insertPort(node, Qan.NodeItem.Right)
                    node.item.x = drop.x - node.item.width/2
                    node.item.y = drop.y - node.item.height/2
                }
            }

            Qan.FaceGraph {
                id: topology
                objectName: "graph"
                anchors.fill: parent
                connectorEnabled: true
                connectorHEdgeEnabled: true
                onNodeInserted: {
                    tree.appendNode(node.label, node.type)
                }
            }
        }
        NodesList {
            width: 150
            Layout.fillHeight: true
        }
    }
}
