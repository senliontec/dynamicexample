#include "modulemanager.h"

#include <src/API/temperature.h>
#include <src/API/formdata.h>
#include <src/API/temperature.h>


#include <QQmlContext>

ModuleManager::ModuleManager()
{

}

void ModuleManager::initQmlRegisterInterface()
{
    qmlRegisterType<FormData>("EasyModel", 1, 0, "FormData");
}

void ModuleManager::initQmlObjInterface()
{
    // Initialize modules
    auto temperature = Temperature::getInstance();
    auto c = engine()->rootContext();
    c->setContextProperty("Cpp_API_Temperature", temperature);
    engine()->load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
}

QQmlApplicationEngine *ModuleManager::engine()
{
    return &m_engine;
}
