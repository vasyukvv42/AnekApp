#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "anekapi.h"
#include "androidutils.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<AndroidUtils>("AndroidUtils", 0, 1, "AndroidUtils");
    qmlRegisterType<AnekAPI>("AnekAPI", 0, 1, "AnekAPI");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
