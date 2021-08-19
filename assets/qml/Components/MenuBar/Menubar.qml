import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
MenuBar {
    id: root
    visible: app.menubarEnabled

    //
    // Set background color + border
    //
    background: Rectangle {
        gradient: Gradient {
            GradientStop {
                position: 0
                color: Qt.lighter(app.windowBackgroundColor)
            }

            GradientStop {
                position: 1
                color: app.windowBackgroundColor
            }
        }
    }

    Component.onCompleted: app.menuBar = this

    /**File**/
    Menu {
        title: qsTr("File")
        DecentMenuItem {
            sequence: "ctrl+o"
            text: qsTr("CSV export") + "..."
            onTriggered: Cpp_CSV_Player.openFile()
        }

        DecentMenuItem {
            text: qsTr("Quit")
            onTriggered: Qt.quit()
            sequence: StandardKey.Quit
        }
    }

    //
    // Edit menu
    //
    Menu {
        title: qsTr("Run")

        DecentMenuItem {
            text: qsTr("Copy")
            sequence: StandardKey.Copy
            onTriggered: app.copyConsole()
        }

        DecentMenuItem {
            sequence: StandardKey.SelectAll
            text: qsTr("Select all") + "..."
            onTriggered: app.selectAllConsole()
        }

        DecentMenuItem {
            sequence: StandardKey.Delete
            onTriggered: app.clearConsole()
            text: qsTr("Clear console output")
        }

        MenuSeparator{}

        Menu {
            title: qsTr("Communication mode")

            DecentMenuItem {
                checkable: true
                text: qsTr("Device sends JSON")

            }

            DecentMenuItem {
                checkable: true
                text: qsTr("Load JSON from computer")

            }
        }
    }

    //
    // Help menu
    //
    Menu {
        title: qsTr("Windows")
    }
}
