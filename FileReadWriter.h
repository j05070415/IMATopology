/**
* \file FileReadWriter.h
* \author DotDot
* \copyright Copyright (C), 2015-2017, All rights reserved.
*/
#ifndef FILEREADWRITER_H
#define FILEREADWRITER_H

#include <QString>
#include <QObject>

/**
 * @brief FileReadWriter用于文本文件读写
 */
class FileReadWriter : public QObject {
    Q_OBJECT
public slots:
    /**
     * @brief read读取指定路径文件文本内容
     * @param path文件路径
     * @return 文件存在则返回文件内容；否则，返回空
     */
    QString read(const QString& path);

    /**
     * @brief write将content写到file中，若路径不存在尝试创建路径
     * @param file存储文件全路径
     * @param content写入文件内容
     * @return 写成功，返回true，否则，false
     */
    bool write(const QString& file, const QString& content);
};

#endif // FILEREADWRITER_H
