#include "diagcontroller.h"
#include <QDebug>

DiagController::DiagController(QObject *parent) : QObject(parent)
{
    controller = new local::qdbuscpp2xml::DiagController("org.BDiag.DiagServer",
                                                         "/org/BDiag/DiagControl",
                                                         QDBusConnection::sessionBus(),
                                                         this);
}

QString DiagController::diagRequest()
{
    // theLight->turnOn();
    QDBusInterface remoteApp( "org.BDiag.DiagServer",               /* service name */
                              "/org/BDiag/DiagControl",             /* object path  */
                              "local.qdbuscpp2xml.DiagController"   /* interface    */
                              );

    if (remoteApp.isValid()) {
    QDBusReply<QString> reply = remoteApp.call( "diagRequest" );
        if (reply.isValid()) {
            printf("Reply was: %s\n", qPrintable(reply.value()));
                     qDebug() <<  qPrintable(reply.value()) ;

        }

        //fprintf(stderr, "Call failed: %s\n", qPrintable(reply.error().message()));
        return reply;
    }

    fprintf(stderr, "%s\n",
            qPrintable(QDBusConnection::sessionBus().lastError().message()));

}
