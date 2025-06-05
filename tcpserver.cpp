#include "tcpserver.hpp"

TcpServer::TcpServer(QObject *parent)
    : QObject{parent}
{

    connect(&_server,&QTcpServer::newConnection,this,&TcpServer::onNewConnection);
    connect(this,&TcpServer::newMessage,this,&TcpServer::onNewMessage);
    if(_server.listen(QHostAddress::Any,4500)){
        qInfo() << "Listening....";

    }
}

void TcpServer::sendMessage(const QString &message)
{
    emit newMessage("Server: " + message.toUtf8());
}

void TcpServer::onNewConnection()
{
    const auto client = _server.nextPendingConnection();
    if(client==nullptr){
            return;
    }

    qInfo() << "New client connected.";

    _Clients.insert(this->getClientKey(client),client);

    connect(client, &QTcpSocket::readyRead,this,&TcpServer::onReadyRead);
    connect(client, &QTcpSocket::disconnected,this,&TcpServer::onDisconnected);


}

void TcpServer::onReadyRead()
{
    const auto client = qobject_cast<QTcpSocket*>(sender());
    if(client ==nullptr){
        return;
    }

    const auto message = this->getClientKey(client).toUtf8() + ": " + client->readAll();

    emit newMessage(message);
}

void TcpServer::onDisconnected()
{
    const auto client = qobject_cast<QTcpSocket*>(sender());
    if(client ==nullptr){
        return;
    }

    _Clients.remove(this->getClientKey(client));

}

void TcpServer::onNewMessage(const QByteArray &ba)
{
    for(const auto &client : qAsConst(_Clients)) {
        client->write(ba);
        client->flush();

    }
}

QString TcpServer::getClientKey(const QTcpSocket *client) const
{
    return client->peerAddress().toString().append(":").append(QString::number(client->peerPort()));
}
