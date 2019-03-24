#include "checknumber.h"

CheckNumber::CheckNumber(QObject *parent) : QObject(parent)
{

}

bool CheckNumber::isNumber(QString str)
{
    bool ok;
    str.toInt(&ok, 10);
    if (str.isEmpty())
        ok = true;
    return ok;
}

void CheckNumber::open()
{
    QString fileName = QFileDialog::getOpenFileName(qobject_cast<QWidget *> (parent()), tr("Open sound file"));
    QUrl url = QUrl::fromLocalFile(fileName);
    emit signalFileName(fileName);
}
