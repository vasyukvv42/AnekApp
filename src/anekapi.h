#ifndef ANEKAPI_H
#define ANEKAPI_H

#include <QObject>
#include <QTcpSocket>
#include <QAbstractSocket>

#include <memory>

class AnekAPIPrivate;

class AnekAPI : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text CONSTANT)
    Q_PROPERTY(QString pub READ pub CONSTANT)
    Q_PROPERTY(QString likes READ likes CONSTANT)
    Q_PROPERTY(QString hostname READ hostname WRITE setHostname)
    Q_PROPERTY(int port READ port WRITE setPort)

    std::unique_ptr<AnekAPIPrivate> d_ptr;
public:
    explicit AnekAPI(QObject *parent = nullptr);

    ~AnekAPI();

    Q_INVOKABLE void connectToServer();
    Q_INVOKABLE void requestAnek();

    QString text() const;
    QString pub() const;
    int likes() const;

    QString hostname() const;
    void setHostname(const QString &hostname);

    int port() const;
    void setPort(int port);
signals:
    void connected();
    void anekReady();
    void errorMessage(const QString &message);
public slots:
    void on_socketReadyRead();
    void on_error(QAbstractSocket::SocketError error);
};

#endif // ANEKAPI_H
