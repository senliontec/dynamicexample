import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

MenuItem {
    id: root

    property alias sequence: _shortcut.sequence
    property bool indicatorVisible: root.icon.source.length > 0 || root.checkable

    Shortcut {
        id: _shortcut
        enabled: root.enabled
        onActivated: root.triggered()
    }

    contentItem: RowLayout {
        spacing: 0
        width: root.width
        opacity: root.enabled ? 1 : 0.5

        Item {
            width: root.indicatorVisible ? root.indicator.width + 4 : 0
        }

        Label {
            text: root.text
            Layout.fillWidth: true
            elide: Label.ElideRight
            verticalAlignment: Qt.AlignVCenter
        }

        Item {
            Layout.fillWidth: true
        }

        Label {
            text: _shortcut.nativeText
            verticalAlignment: Qt.AlignVCenter
        }
    }
}
