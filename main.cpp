#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "checknumber.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    CheckNumber check;

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    engine.rootContext()->setContextProperty("check", &check);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
