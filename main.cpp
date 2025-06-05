#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "tcpserver.hpp"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("./Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj,const QUrl &objUrl) {
            if(!obj && url == objUrl)
            QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    TcpServer tcpServer;
    engine.rootContext()->setContextProperty("server",&tcpServer);

    engine.loadFromModule("simpleChatServer","Main");

    return app.exec();
}
