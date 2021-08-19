#include "formdata.h"

#include <QDebug>

FormData::FormData(QObject *parent)
    : QAbstractTableModel(parent)
{
}

QStringList FormData::getHorHeader() const
{
    return _horHeaderList;
}

void FormData::setHorHeader(const QStringList &header)
{
    _horHeaderList = header;
    emit horHeaderChanged();
}

QJsonArray FormData::getInitData() const
{
    return _initData;
}

void FormData::setInitData(const QJsonArray &jsonArr)
{
    _initData = jsonArr;
    if (_completed) {
        loadData(_initData);
    }
    emit initDataChanged();
}

void FormData::classBegin()
{
    //qDebug()<<"EasyTableModel::classBegin()";
}

void FormData::componentComplete()
{
    //qDebug()<<"EasyTableModel::componentComplete()";
    _completed = true;
    if (!_initData.isEmpty()) {
        loadData(_initData);
    }
}

QHash<int, QByteArray> FormData::roleNames() const
{
    //value表示取值，edit表示编辑
    return QHash<int, QByteArray> {
        { Qt::DisplayRole, "value" },
        { Qt::EditRole, "edit" }
    };
}

QVariant FormData::headerData(int section, Qt::Orientation orientation, int role) const
{
    //返回表头数据，无效的返回None
    if (role == Qt::DisplayRole) {
        if (orientation == Qt::Horizontal) {
            return _horHeaderList.value(section, QString::number(section));
        } else if (orientation == Qt::Vertical) {
            return QString::number(section);
        }
    }
    return QVariant();
}

bool FormData::setHeaderData(int section, Qt::Orientation orientation, const QVariant &value, int role)
{
    if (value != headerData(section, orientation, role)) {
        if (orientation == Qt::Horizontal && role == Qt::EditRole) {
            _horHeaderList[section] = value.toString();
            emit headerDataChanged(orientation, section, section);
            return true;
        }
    }
    return false;
}


int FormData::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return _modelData.count();
}

int FormData::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return _horHeaderList.count();
}

QVariant FormData::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    switch (role) {
    case Qt::DisplayRole:
    case Qt::EditRole:
        return _modelData.at(index.row()).at(index.column());
    default:
        break;
    }
    return QVariant();
}

bool FormData::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (value.isValid() && index.isValid() && (data(index, role) != value)) {
        if (Qt::EditRole == role) {
            _modelData[index.row()][index.column()] = value;
            emit dataChanged(index, index, QVector<int>() << role);
            return true;
        }
    }
    return false;
}

Qt::ItemFlags FormData::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsEnabled | Qt::ItemIsSelectable | Qt::ItemIsEditable;
}

void FormData::loadData(const QJsonArray &data)
{
    //如果要区分类型的话，可以用role，
    //这样ui中就能使用model.role来获取对应index的参数
    QVector<QVector<QVariant>> newData;
    QJsonArray::const_iterator iter;
    for (iter = data.begin(); iter != data.end(); ++iter) {
        QVector<QVariant> newRow;
        const QJsonObject itemRow = (*iter).toObject();
        newRow.append(itemRow.value("选项"));
        newRow.append(itemRow.value("右上臂前"));
        newRow.append(itemRow.value("右上臂后"));
        newRow.append(itemRow.value("左上臂前"));
        newRow.append(itemRow.value("左上臂后"));
        newRow.append(itemRow.value("右前臂前"));
        newRow.append(itemRow.value("右前臂后"));
        newRow.append(itemRow.value("左前臂前"));
        newRow.append(itemRow.value("左前臂后"));
        newRow.append(itemRow.value("胸上部"));
        newRow.append(itemRow.value("肩背部"));
        newRow.append(itemRow.value("胸腹"));
        newRow.append(itemRow.value("背中部"));
        newRow.append(itemRow.value("腰腹部"));
        newRow.append(itemRow.value("背下部"));
        newRow.append(itemRow.value("右大腿前"));
        newRow.append(itemRow.value("右大腿后"));
        newRow.append(itemRow.value("左大腿前"));
        newRow.append(itemRow.value("左大腿后"));
        newRow.append(itemRow.value("右小腹前"));
        newRow.append(itemRow.value("右臂"));
        newRow.append(itemRow.value("左小腹前"));
        newRow.append(itemRow.value("左臀"));
        newRow.append(itemRow.value("右小腿前"));
        newRow.append(itemRow.value("右小腿后"));
        newRow.append(itemRow.value("左小腿前"));
        newRow.append(itemRow.value("左小腿后"));
        newRow.append(itemRow.value("左脚"));
        newRow.append(itemRow.value("右脚"));
        newRow.append(itemRow.value("头部"));
        newData.append(newRow);
    }

    emit beginResetModel();
    _modelData = newData;
    emit endResetModel();
}

/*
bool EasyTableModel::insertRows(int row, int count, const QModelIndex &parent)
{
    beginInsertRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endInsertRows();
}

bool EasyTableModel::insertColumns(int column, int count, const QModelIndex &parent)
{
    beginInsertColumns(parent, column, column + count - 1);
    // FIXME: Implement me!
    endInsertColumns();
}

bool EasyTableModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row + count - 1);
    // FIXME: Implement me!
    endRemoveRows();
}

bool EasyTableModel::removeColumns(int column, int count, const QModelIndex &parent)
{
    beginRemoveColumns(parent, column, column + count - 1);
    // FIXME: Implement me!
    endRemoveColumns();
}*/
