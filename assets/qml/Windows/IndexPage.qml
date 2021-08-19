import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.12 as QtWindow

import Qt.labs.settings 1.0
import "../Components/GraphicDisplay" as Widgets
import "../Components/SideBar"


Control {
    id: root
    property string title
    property var subgraph: []

    background: Rectangle {
        color: app.windowBackgroundColor
    }
    ColumnLayout {
        x: 2 * app.spacing
        anchors.fill: parent
        spacing: app.spacing * 2
        anchors.margins: app.spacing * 1.5


        /** Group data & graphs **/
        RowLayout {
            spacing: app.spacing
            Layout.fillWidth: true
            Layout.fillHeight: true

            /* View options */
            Widgets.Window {
                id: viewOptions
                gradient: true
                Layout.fillHeight: true
                Layout.minimumWidth: 240
                backgroundColor: "#121218"
                headerDoubleClickEnabled: false
                icon.source: "qrc:/icons/visibility.svg"
                title: qsTr("View")


                ScrollView {
                    clip: true
                    contentWidth: -1
                    anchors.fill: parent
                    anchors.margins: app.spacing
                    anchors.topMargin: viewOptions.borderWidth
                    anchors.bottomMargin: viewOptions.borderWidth

                    IndexSidebar{
                        id: indexsidebar
                        anchors.margins: 0
                        width: 300
                        anchors{
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                            margins: 10
                        }
                    }
                }
            }


            /* Data grid */
            Widgets.Window {
                id: dataWin
                gradient: true
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumWidth: 240
                backgroundColor: "#121218"
                headerDoubleClickEnabled: false
                icon.source: "qrc:/icons/scatter-plot.svg"
                title: qsTr("Data")

                Rectangle {
                    z: 1
                    color: dataWin.borderColor
                    height: dataWin.borderWidth

                    anchors {
                        leftMargin: 5
                        rightMargin: 5
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                }
                ScrollView {
                    z: 0
                    id: _sv
                    clip: false
                    contentWidth: -1
                    anchors.fill: parent
                    anchors.rightMargin: 10
                    anchors.margins: app.spacing * 2
                    anchors.leftMargin: app.spacing * 2 + 10

                    ColumnLayout {
                        width: _sv.width - 2 * app.spacing

                        Item {
                            Layout.minimumHeight: 10
                        }
                        GridLayout {
                            rowSpacing: 0
                            columnSpacing: 0
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            columns: 2

                            Repeater {
                                id: graphGenerator
                                delegate: Item {
                                    id: graphic_item
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.minimumHeight: graphDelegate.visible ? 600 : 0

                                    Widgets.GraphDelegate {
                                        id: graphDelegate
                                        graphId: index
                                        anchors.fill: parent
                                        anchors.margins: app.spacing
                                        onHeaderDoubleClicked:{
                                            graphWindow.show()
                                        }
                                    }

                                    QtWindow.Window {
                                        id: graphWindow
                                        width: 640
                                        height: 480
                                        minimumWidth: 320
                                        minimumHeight: 256

                                        Rectangle {
                                            anchors.fill: parent
                                            color: graph.backgroundColor
                                        }

                                        Widgets.GraphDelegate {
                                            id: graph
                                            graphId: index
                                            title: graphDelegate.title
                                            showIcon: true
                                            headerHeight: 48
                                            anchors.margins: 0
                                            anchors.fill: parent
                                            enabled: graphWindow.visible
                                            borderColor: backgroundColor
                                            headerDoubleClickEnabled: false
                                            icon.source: "qrc:/icons/chart.svg"
                                            Component.onCompleted: {
                                                subgraph.push(graph)
                                            }
                                        }
                                    }
                                }

                            }
                        }
                        Item {
                            Layout.minimumHeight: 10
                        }
                    }
                }
            }
        }
    }
}
