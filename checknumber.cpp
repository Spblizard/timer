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
