#ifndef ANEKAPI_P_H
#define ANEKAPI_P_H

#include "anekapi.h"

class AnekAPIPrivate
{
public:
    QTcpSocket *socket;

    QString hostname {"localhost"};
    int port {8080};
    QByteArray buffer;

    QString text;
    QString pub;
    int likes;
};

#endif // ANEKAPI_P_H
