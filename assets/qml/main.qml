import QtQuick 2.7
import QtQuick.Controls 2.15
import QtQuick.Window 2.12
import QtQuick.Controls.Styles 1.4
import Qt.labs.settings 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0

import "Windows"

ApplicationWindow {
    id: app
    visibility: "Maximized"

    /**Global properties**/
    readonly property int spacing: 8
    readonly property color windowBackgroundColor: "#121920"
    property bool menubarEnabled: true
    property bool windowMaximized: true
    property bool firstChange: true
    property bool fullScreen: false
    readonly property string monoFont: {
        switch (Qt.platform.os) {
        case "osx":
            return "Monaco"
        case "windows":
            return "Consolas"
        default:
            return "Monospace"
        }
    }

    /**Hacks to fix window maximized behavior**/
    onVisibilityChanged: {
        if (visibility == Window.Maximized) {
            if (!windowMaximized)
                firstChange = false

            windowMaximized = true
            fullScreen = false
        }

        else if (visibility === Window.FullScreen) {
            if (!fullScreen)
                firstChange = false

            windowMaximized = false
            fullScreen = true
        }
    }

    /** Application UI status variables (used for the menubar)**/

    /**Theme options**/
    palette.text: "#fff"
    palette.buttonText: "#fff"
    palette.windowText: "#fff"
    palette.window: app.windowBackgroundColor
    background: Rectangle {
        color: app.windowBackgroundColor
    }


    /**Save window size & position**/
    Settings {
        property alias appX: app.x
        property alias appY: app.y
        property alias appW: app.width
        property alias appH: app.height
//        property alias appStatus: app.appLaunchStatus
//        property alias windowFullScreen: app.fullScreen
//        property alias autoUpdater: app.automaticUpdates
        property alias appMaximized: app.windowMaximized
        property alias menubarVisible: app.menubarEnabled
    }

    /** Startup timer **/


    /**start app**/
    Component.onCompleted: {
    }


    Loader {
        asynchronous: false
        source: {
//            if (Qt.platform.os === "osx")
//                return "qrc:/qml/PlatformDependent/MenubarMacOS.qml"
            return "qrc:/qml/Components/MenuBar/Menubar.qml"
        }
    }

    /**main layout**/
    MainLayout{
        id: mainpage
        anchors.fill: parent
    }
}



