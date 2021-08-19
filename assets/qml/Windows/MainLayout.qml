import QtQuick 2.0
import QtQuick.Controls 1.4 as QC14
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

import "../Components/SideBar"
import "../Components/GraphicDisplay" as Widgets
import "../Components/MenuBar"
import "../Components/ToolBar"

Item {
    width: app.contentItem.width
    height: app.contentItem.height
    Toolbar{
        id: toolbar
        onDataGirdBtnClicked: {
            layout.currentIndex = 0
        }
        onGraphicsBtnClicked: {

        }
        onFormdataBtnClicked: {
            layout.currentIndex = 1
        }
    }

    StackLayout {
        id: layout
        width: app.contentItem.width
        height: app.contentItem.height

        currentIndex: 0
        /** 首页 **/
        IndexPage{
            id: indexpage
        }

        /** 第二页 **/
        RowLayout{
            spacing: 15
            Layout.fillWidth: true
            Layout.fillHeight: true
            Item {
                Layout.minimumHeight: 15
            }

            Widgets.Window {
                id: dataWin
                gradient: true
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumWidth: 240
                anchors.leftMargin: 10
                backgroundColor: "#121218"
                headerDoubleClickEnabled: false
                icon.source: "qrc:/icons/scatter-plot.svg"
                title: qsTr("Data")

                QC14.TabView{
                    width: dataWin.width
                    height: dataWin.height
                    anchors{
                        fill:parent
                        leftMargin: 10
                        rightMargin: 10
                        bottomMargin: 10
                    }

                    style: TabViewStyle {
                            frameOverlap: 1
                            tabsAlignment: Qt.AlignHCenter
                            tab: Rectangle {
                                color: styleData.selected ? "steelblue" :"lightsteelblue"
                                border.color:  "steelblue"
                                implicitWidth: Math.max(text.width + 4, 80)
                                implicitHeight: 25
                                radius: 2
                                Text {
                                    id: text
                                    anchors.centerIn: parent
                                    text: styleData.title
                                    color: styleData.selected ? "white" : "black"
                                }
                            }
                            frame: Rectangle {
                                color: app.windowBackgroundColor
                                border.width: 2
                                border.color: "steelblue"
                            }
                        }
                    QC14.Tab{
                        title: "温度设置"

                        anchors{
                            leftMargin: 20
                            rightMargin: 20
                        }

                        FormPage{
                            id: formdata
                        }
                    }
                }
            }

            Item {
                Layout.minimumHeight: 15
            }
        }
    }
}
