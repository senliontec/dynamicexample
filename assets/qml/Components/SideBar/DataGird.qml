import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.11

Item {
    id:root
    width: 300
    height: 1000
//    visible: false
    ListView{
        id:listView
        anchors.fill: parent
        anchors.top: parent.top
        anchors.topMargin:20
        spacing: 20
        Material.background: "white"
        model: ListModel{
            id:listModel
        }
        delegate: list_delegate
    }

    Component.onCompleted: {
        addModelData("Manikin Zones")
        addModelData("Heater Control")
        addModelData("Ambient")
        addModelData("Fluid Preheater")
        addModelData("Group Weighted Average")
    }
    ListModel {
        id: libraryModel
        ListElement {
            title: "A Masterpiece"
            author: "Gabriel"
        }
        ListElement {
            title: "Brilliance"
            author: "Jens"
        }
        ListElement {
            title: "Outstanding"
            author: "Frederik"
        }
    }

    Component{
        id: list_delegate
        Column{
            id:objColumn
            Component.onCompleted: {
                objColumn.children[2].visible = false
            }
            MouseArea{
                width:listView.width
                height: objItem.height
                onClicked: {
                    if (objColumn.children[2].visible){
                        objColumn.children[2].visible = false
                    }else{
                        objColumn.children[2].visible = true
                    }
                }
            }
            Rectangle{
                Row{
                    id:objItem
                    spacing: 10
                    Image {
                        id: arrow
                        height: 20
                        source: "qrc:/images/right_arrows.png"
                    }
                    Label{
                        color: "white"
                        id:meeting_name
                        text: meetingName
                        font.pixelSize: fontSizeMedium
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            TableView{
                id: tableview
                TableViewStyle{
                    id: tb_style
                }
            }
        }
    }


    function addModelData(meetingName){
        var index = findIndex(meetingName)
        if(index === -1){
            listModel.append({"meetingName":meetingName})
        }
    }
    function findIndex(name){
        for(var i = 0 ; i < listModel.count ; ++i){
            if(listModel.get(i).meetingName === name){
                return i
            }
        }
        return -1
    }
}
