#ifndef CHECKNUMBER_H
#define CHECKNUMBER_H

#include <QObject>

class CheckNumber : public QObject
{
    Q_OBJECT
public:
    explicit CheckNumber(QObject *parent = nullptr);

signals:

public slots:
    bool isNumber(QString);
};

#endif // CHECKNUMBER_H
