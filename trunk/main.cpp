#include <QtGui/QApplication>
#include <QCoreApplication>

#include "applicationlogic.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QCoreApplication::setOrganizationName("Juhapekka Piiroinen");
    QCoreApplication::setOrganizationDomain("jpii.fi");
    QCoreApplication::setApplicationName("CuteAuthenticator");

    ApplicationLogic appLogic;

    int retval = app.exec();

    appLogic.deleteLater();

    return retval;
}
