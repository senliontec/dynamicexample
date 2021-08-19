#ifndef TEMPERATURE_H
#define TEMPERATURE_H

#include <QAbstractSeries>
#include <QObject>
#include <QTimer>
#include <QVariant>
#include <QVector>
#include <QtCharts/QAbstractSeries>
#include <QtCharts/QAreaSeries>
#include <QtCharts/QXYSeries>
#include <QtCore/QObject>
#include <QtCore/QRandomGenerator>
#include <QtCore/QtMath>
#include <QtQuick/QQuickItem>
#include <QtQuick/QQuickView>

QT_BEGIN_NAMESPACE
class QQuickView;
QT_END_NAMESPACE

QT_CHARTS_USE_NAMESPACE

class Temperature : public QObject {
  Q_OBJECT
public:
  Temperature();
  static Temperature *getInstance();
Q_SIGNALS:

public slots:
  void update(QAbstractSeries *series, const int index);
  void updateCurve();

private:
  QQuickView *m_appViewer;
  QVector<QVector<QPointF>> m_data;
  int m_index;
  QTimer *mytimer;
};

#endif // TEMPERATURE_H
