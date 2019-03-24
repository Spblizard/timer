#ifndef CHECKNUMBER_H
#define CHECKNUMBER_H

#include <QObject>
#include <QDebug>
#include <QFileDialog>

class CheckNumber : public QObject
{
    Q_OBJECT
public:
    explicit CheckNumber(QObject *parent = nullptr);

signals:
    void signalFileName(QUrl url);

public slots:
    bool isNumber(QString);
    void open();
};

#endif // CHECKNUMBER_H
