#-----------------------------------------------------------------------------------------
# Qt configuration
#-----------------------------------------------------------------------------------------
QT += quick
QT += widgets
QT += charts
QT += quickcontrols2
QT += qml
CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

#-----------------------------------------------------------------------------------------
# Deploy options
#-----------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------
# Import source code
#-----------------------------------------------------------------------------------------
SOURCES += \
        main.cpp \
        src/API/formdata.cpp \
        src/API/temperature.cpp \
        src/Common/modulemanager.cpp \

HEADERS += \
    src/API/formdata.h \
    src/API/temperature.h \
    src/AppInfo.h \
    src/Common/modulemanager.h \

RESOURCES += \
    assets/assets.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


DISTFILES += \
    assets/qml/*.qml \
    assets/qml/Components/GraphicDisplay/DataDelegate.qml \
    assets/qml/Components/GraphicDisplay/ExperimentScreen.qml \
    assets/qml/Components/GraphicDisplay/GraphDelegate.qml \
    assets/qml/Components/GraphicDisplay/GroupDelegate.qml \
    assets/qml/Components/GraphicDisplay/Window.qml \
    assets/qml/Components/MenuBar/Menubar.qml \
    assets/qml/Components/MenuBar/DecentMenuItem.qml \
    assets/qml/Components/SideBar/IndexSidebar.qml \
    assets/qml/Components/ToolBar/Toolbar.qml \
    assets/qml/Windows/FormPage.qml \
    assets/qml/Windows/IndexPage.qml \
    assets/qml/Windows/MainLayout.qml





