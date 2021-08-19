import QtQuick 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4

ToolBar {
    id: root
    height: 50
    /**background**/
    ToolBarStyle {
        padding {
            left: 8
            right: 8
            top: 3
            bottom: 3
        }
    }
    Rectangle {
        gradient: Gradient {
            GradientStop { position: 0; color: "#21373f" }
            GradientStop { position: 1; color: "#11272f" }
        }
        anchors {
            fill: parent
        }
    }

    signal dataGirdBtnClicked()
    signal formdataBtnClicked()
    signal graphicsBtnClicked()

    property alias btn_datagird_isChecked: btn_datagird.checked
    property alias btn_formdata_isChecked: btn_formdata.checked

    Component.onCompleted: app.header = this

    RowLayout{
        id: hlayout
        spacing: 8
        ToolButton {
            id: btn_datagird
            topInset: 5
            bottomInset: 5
            height: 20
            text: "Graphics"
            icon.source:  "qrc:/icons/developer-board.svg"
            onClicked: root.dataGirdBtnClicked()
        }
        ToolButton{
            id: btn_formdata
            height: 20
            topInset: 5
            bottomInset: 5
            text: "FormData"
            icon.source:  "qrc:/icons/table.svg"
            onClicked: root.formdataBtnClicked()
        }
    }
}



