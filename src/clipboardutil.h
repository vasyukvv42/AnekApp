#ifndef CLIPBOARDUTIL_H
#define CLIPBOARDUTIL_H

#include <QObject>
#include <QClipboard>

class ClipboardUtil : public QObject
{
    Q_OBJECT
    QClipboard *clipboard;
public:
    explicit ClipboardUtil(QObject *parent = nullptr);
    explicit ClipboardUtil(QClipboard *clipboard);
    Q_INVOKABLE void setText(const QString &text);
};

#endif // CLIPBOARDUTIL_H
