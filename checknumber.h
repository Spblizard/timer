#ifndef CHECKNUMBER_H
#define CHECKNUMBER_H

#include <QObject>
#include <QDebug>
#include <QFileDialog>
#include <QFileInfo>

class CheckNumber : public QObject
{
    Q_OBJECT
public:
    explicit CheckNumber(QObject *parent = nullptr);

signals:
    void signalFileName(QUrl url,QString name);

public slots:
    bool isNumber(QString);
    void open();
};

#endif // CHECKNUMBER_H
