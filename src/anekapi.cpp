#include "anekapi.h"
#include "anekapi_p.h"

#include <QJsonDocument>
#include <QJsonObject>

AnekAPI::AnekAPI(QObject *parent)
    : QObject(parent),
      d_ptr(std::make_unique<AnekAPIPrivate>())
{
    d_ptr->socket = new QTcpSocket(this);

    connect(d_ptr->socket, SIGNAL(readyRead()), this, SLOT(on_socketReadyRead()));
    connect(d_ptr->socket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(on_error(QAbstractSocket::SocketError)));
    connect(d_ptr->socket, SIGNAL(connected()), this, SIGNAL(connected()));
}

AnekAPI::~AnekAPI()
{
    d_ptr->socket->close();
}

void AnekAPI::connectToServer()
{
    qDebug() << "Connecting to server...";
    d_ptr->socket->connectToHost(d_ptr->hostname, d_ptr->port);
}

void AnekAPI::requestAnek()
{
    if (d_ptr->socket->state() != QAbstractSocket::ConnectedState) {
        qDebug() << "Reconnecting to server...";
        d_ptr->socket->connectToHost(d_ptr->hostname, d_ptr->port);
    } else {
        qDebug() << "Requesting anek...";
        d_ptr->socket->write("Anek");
    }
}

void AnekAPI::on_socketReadyRead()
{
    d_ptr->buffer.push_back(d_ptr->socket->readAll());
    auto jsonDocument = QJsonDocument::fromJson(d_ptr->buffer);

    if (!jsonDocument.isEmpty()) {
        qDebug() << "Full JSON recieved!";
        qDebug() << d_ptr->buffer;

        auto jsonObject = jsonDocument.object();

        d_ptr->text = jsonObject["text"].toString();
        d_ptr->likes = jsonObject["likes"].toInt();
        d_ptr->pub = jsonObject["pub"].toString();

        d_ptr->buffer.clear();
        emit anekReady();
    } else {
        qDebug() << "Recieved a part of JSON";
    }
}

void AnekAPI::on_error(QAbstractSocket::SocketError error)
{
    qDebug() << "Error occurred:" << error;
    if (error != QAbstractSocket::SocketError::RemoteHostClosedError)
        emit errorMessage("Connection error");
}

QString AnekAPI::text() const
{
    return d_ptr->text;
}

QString AnekAPI::pub() const
{
    return d_ptr->pub;
}

int AnekAPI::likes() const
{
    return d_ptr->likes;
}

QString AnekAPI::hostname() const
{
    return d_ptr->hostname;
}

void AnekAPI::setHostname(const QString &hostname)
{
    d_ptr->hostname = hostname;
}

int AnekAPI::port() const
{
    return d_ptr->port;
}

void AnekAPI::setPort(int port)
{
    d_ptr->port = port;
}
