#ifndef MODULEMANAGER_H
#define MODULEMANAGER_H

#include <QObject>
#include <QQmlApplicationEngine>
class ModuleManager
{
public:
    ModuleManager();

    QQmlApplicationEngine *engine();
    void initQmlRegisterInterface();
    void initQmlObjInterface();
private:
    QQmlApplicationEngine m_engine;
};

#endif // MODULEMANAGER_H
