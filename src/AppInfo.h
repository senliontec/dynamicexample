#ifndef APPINFO_H
#define APPINFO_H
#include <QDir>
#include <QString>

// clang-format off
#define APP_VERSION     "1.0.21"
#define APP_DEVELOPER   "Senlion"
#define APP_NAME        "Dummy Monitor"
//#define APP_ICON        ":/images/icon.png"
#define APP_SUPPORT_URL "https://github.com/serial-studio"
#define APP_UPDATER_URL "https://raw.githubusercontent.com/Serial-Studio/Serial-Studio/master/updates.json"
#define LOG_FORMAT      "[%{time}] %{message:-72} [%{TypeOne}] [%{function}]\n"
#define LOG_FILE        QString("%1/%2.log").arg(QDir::tempPath(), APP_NAME)
// clang-format on

#endif // APPINFO_H
