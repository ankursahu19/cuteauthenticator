#ifndef APPLICATIONLOGIC_H
#define APPLICATIONLOGIC_H

#include <QObject>
#include "qmlapplicationviewer.h"

#include "roleitemmodel.h"
#include <QDeclarativeEngine>
#include <QDeclarativeContext>
#include <QSettings>
#include <QDebug>

struct AccountsKeys {
    enum AccountsRoles {
            NameRole = Qt::UserRole + 1,
            SecretKeyRole,
    };
};

class ApplicationLogic : public QObject
{
    Q_OBJECT
public:
    explicit ApplicationLogic(QObject *parent = 0);
    ~ApplicationLogic() {
        m_accountsmodel->deleteLater();
        m_viewer.deleteLater();
        m_ctxt->deleteLater();
        m_accountsmodel->clear();
    }

signals:

public slots:
    void addAccount(QString name, QString secretkey);
    void removeAccount(int index);

protected:
     QHash<int, QByteArray> m_roleNames;
     RoleItemModel* m_accountsmodel;
     QmlApplicationViewer m_viewer;
     QDeclarativeContext* m_ctxt;
     QSettings settings;
     QList<QStandardItem*> m_items;
};

#endif // APPLICATIONLOGIC_H
