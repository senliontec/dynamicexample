#include <QApplication>
#include <QQmlApplicationEngine>
#include <QSysInfo>

#include "src/AppInfo.h"
#include "src/Common/modulemanager.h"

#ifdef Q_OS_WIN
#    include <windows.h>
#endif

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    // Init. application
    QApplication app(argc, argv);
    app.setApplicationName(APP_NAME);
    app.setApplicationVersion(APP_VERSION);
    app.setOrganizationName(APP_DEVELOPER);
    app.setOrganizationDomain(APP_SUPPORT_URL);


    ModuleManager moduleManager;
    moduleManager.initQmlRegisterInterface();
    moduleManager.initQmlObjInterface();

//    QQmlApplicationEngine engine;
//    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//    &app, [url](QObject * obj, const QUrl & objUrl) {
//        if (!obj && url == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);
//    engine.load(url);

    return app.exec();
}
