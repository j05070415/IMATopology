#include "FileReadWriter.h"

#include <QFile>
#include <QDebug>

QString FileReadWriter::read(const QString &path)
{
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) return "";

    return file.readAll();
}

bool FileReadWriter::write(const QString &path, const QString &content)
{
    QFile file(path);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) return false;

    return file.write(content.toUtf8()) != -1;
}
