#ifndef DIAGCONTROLLER_H
#define DIAGCONTROLLER_H

#include <QObject>
#include "controller_interface.h"

class DiagController: public QObject
{
    Q_OBJECT
public:
    explicit DiagController(QObject *parent = nullptr);

public slots:
    QString diagRequest();

private:
    local::qdbuscpp2xml::DiagController *controller;

};

#endif // DIAGCONTROLLER_H
