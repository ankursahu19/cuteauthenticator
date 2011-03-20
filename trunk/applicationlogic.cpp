#include "applicationlogic.h"

ApplicationLogic::ApplicationLogic(QObject *parent) :
    QObject(parent)
{
    m_roleNames[AccountsKeys::NameRole] =  "name";
    m_roleNames[AccountsKeys::SecretKeyRole] = "secretkey";
    m_accountsmodel = new RoleItemModel(m_roleNames);

       // addAccount("Google","c vhb tu2 rwr 2zh bpu");

    QStringList accountNames = settings.allKeys();
    foreach(QString name, accountNames) {
        addAccount(name,settings.value(name).toString());
    }

    m_ctxt = m_viewer.rootContext();
    m_ctxt->setContextProperty("logic", this);
    m_ctxt->setContextProperty("accountModel",m_accountsmodel);

    m_viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    m_viewer.setMainQmlFile(QLatin1String("qml/CuteAuthenticator/main.qml"));

    m_viewer.showExpanded();
}

void ApplicationLogic::removeAccount(int index) {
    QStandardItem* item = m_accountsmodel->item(index);
    settings.remove(item->data(AccountsKeys::NameRole).toString());
    m_accountsmodel->removeRow(index);
}

void ApplicationLogic::addAccount(QString name, QString secretkey) {
    if (name.length()==0 || secretkey.length()==0) {
        return;
    }
    QStandardItem* it = new QStandardItem();
    it->setData(name, AccountsKeys::NameRole);
    it->setData(secretkey, AccountsKeys::SecretKeyRole);
    m_accountsmodel->appendRow(it);
    m_items.append(it);
    settings.setValue(name,secretkey);
}


