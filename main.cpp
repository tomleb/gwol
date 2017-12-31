#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

#include "gwol.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    //QQuickStyle::setStyle("");
    QQmlApplicationEngine engine;

    qmlRegisterType<Gwol>("gwol.components", 1, 0, "Gwol");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
