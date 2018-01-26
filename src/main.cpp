#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QClipboard>

#include "anekapi.h"
#include "androidutils.h"
#include "clipboardutil.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    ClipboardUtil clipboard(app.clipboard());

    engine.rootContext()->setContextProperty("clipboard", &clipboard);
    qmlRegisterType<AndroidUtils>("AndroidUtils", 1, 0, "AndroidUtils");
    qmlRegisterType<AnekAPI>("AnekAPI", 1, 0, "AnekAPI");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
