#include "clipboardutil.h"

ClipboardUtil::ClipboardUtil(QObject *parent) :
    QObject(parent)
{  
}

ClipboardUtil::ClipboardUtil(QClipboard *clipboard) :
    QObject(clipboard),
    clipboard(clipboard)
{
}

void ClipboardUtil::setText(const QString &text)
{
    if (clipboard)
        clipboard->setText(text);
}
