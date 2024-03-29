#ifndef ROLEITEMMODEL_H
#define ROLEITEMMODEL_H

#include <QStandardItemModel>
//http://wiki.forum.nokia.com/index.php/File:Roleitemmodel.zip
/* Convenience class to allow easily exposing
   C++ data as a model for QML View.

   This wouldn't need to exist if setRoleNames was
   a public member of QStandardItemModel
*/

class RoleItemModel : public QStandardItemModel
{
public:
    /* Ctor. roleNames is a map describing when role id (e.g. Qt::UserRole+1)
      is associated with what name on QML side (e.g. 'bookTitle')
      */
    RoleItemModel(const QHash<int, QByteArray> &roleNames);


    // Extract data from items in model as variant map
    // e.g. { "bookTitle" : QVariant("Bible"), "year" : QVariant(-2000) }
    static QVariantMap getModelData(const QAbstractItemModel *mdl, int row);

};

#endif // ROLEITEMMODEL_H
