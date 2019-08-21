#ifndef DIAGCONTROLLER_H
#define DIAGCONTROLLER_H

#include <QObject>
#include "controller_interface.h"

class DiagController: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString diagFram READ diagFram WRITE setDiagFram NOTIFY diagFramChanged)

public:
    explicit DiagController(QObject *parent = nullptr);

    QString diagFram();
    void setDiagFram(const QString &diagFram);

public slots:
    QString diagRequest();

signals:
    void diagFramChanged();

private:
    local::qdbuscpp2xml::DiagController *controller;

    QString m_diagFram;
};

#endif // DIAGCONTROLLER_H
