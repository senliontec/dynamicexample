import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Page {
    id: root
    clip: true
    //
    // Custom properties
    //
    property int borderWidth: 3
    property alias icon: _bt.icon
    property bool gradient: false
    property int headerHeight: 32
    property bool headerVisible: true
    property alias showIcon: _bt.visible
    property int radius: root.borderWidth + 2
    property color titleColor: palette.brightText
    property color borderColor: palette.highlight
    property color backgroundColor: app.windowBackgroundColor
    property alias headerDoubleClickEnabled: headerMouseArea.enabled
    property color gradientColor: root.gradient ? "#058ca7" : root.borderColor

    //
    // Signals
    //
    signal headerDoubleClicked()

    //
    // Animations
    //
    Behavior on opacity {NumberAnimation{}}
    Behavior on Layout.preferredWidth {NumberAnimation{}}
    Behavior on Layout.preferredHeight {NumberAnimation{}}

    //
    // Layout properties
    //
    visible: opacity > 0
    Layout.preferredWidth: enabled ? implicitWidth : 0
    Layout.preferredHeight: enabled ? implicitHeight : 0

    //
    // Background widget
    //
    background: Rectangle {
        radius: root.radius
        color: root.backgroundColor
        border.width: root.borderWidth
        border.color: root.gradientColor
    }

    //
    // Window title & controls
    //
    header: Rectangle {
        radius: root.radius
        color: root.borderColor
        height: root.headerHeight
        visible: root.headerVisible

        gradient: Gradient {
            GradientStop {
                position: 0
                color: root.borderColor
            }

            GradientStop {
                position: 1
                color: root.gradientColor
            }
        }

        Rectangle {
            z: 5
            color: root.gradientColor
            height: root.gradient ? 1 : parent.radius

            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
        }

        MouseArea {
            id: headerMouseArea
            hoverEnabled: true
            anchors.fill: parent
            onDoubleClicked: root.headerDoubleClicked()

            onClicked: {
                if (mouse.x >= headerBt.x && mouse.x <= headerBt.x + headerBt.width)
                    root.headerDoubleClicked()
            }

            onContainsMouseChanged: {
                if (containsMouse)
                    headerBt.opacity = 1
                else
                    headerBt.opacity = 0
            }
        }

        RowLayout {
            spacing: 0
            anchors.fill: parent

            ToolButton {
                id: _bt
                z: 1
                flat: true
                enabled: false
                icon.color: root.titleColor
                Layout.alignment: Qt.AlignVCenter
                Layout.maximumHeight: parent.height
                Layout.minimumHeight: parent.height
                Layout.minimumWidth: root.headerHeight
                Layout.maximumWidth: root.headerHeight
                icon.source: "qrc:/icons/equalizer.svg"
                icon.width: root.headerHeight * 24 / 32
                icon.height: root.headerHeight * 24 / 32
            }

            Label {
                font.bold: true
                text: root.title
                Layout.fillWidth: true
                color: root.titleColor
                Layout.alignment: Qt.AlignVCenter
                font.pixelSize: root.headerHeight * 14 / 32
                horizontalAlignment: root.showIcon ? Label.AlignLeft : Label.AlignHCenter
            }

            Button {
                id: headerBt
                flat: true
                opacity: 0
                enabled: false
                icon.color: root.titleColor
                icon.source: "qrc:/icons/open.svg"
                Layout.alignment: Qt.AlignVCenter
                Layout.maximumHeight: parent.height
                Layout.minimumHeight: parent.height
                onClicked: root.headerDoubleClicked()
                Layout.minimumWidth: root.headerHeight
                Layout.maximumWidth: root.headerHeight
                icon.width: root.headerHeight * 24 / 32
                icon.height: root.headerHeight * 24 / 32
                Behavior on opacity {NumberAnimation{}}
            }
        }
    }
}
