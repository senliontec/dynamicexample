#include "temperature.h"
#include <QAbstractSeries>
#include <QDebug>

static Temperature *INSTANCE = nullptr;

QT_CHARTS_USE_NAMESPACE

Q_DECLARE_METATYPE(QAbstractSeries *)
Q_DECLARE_METATYPE(QAbstractAxis *)

Temperature::Temperature() : m_index(0) {
  qRegisterMetaType<QAbstractSeries *>();
  qRegisterMetaType<QAbstractAxis *>();

  m_data.resize(30);
  for (int i = 0; i < 30; i++) {
    m_data[i].clear();
  }

  mytimer = new QTimer();
  mytimer->start(1000);
  connect(mytimer, SIGNAL(timeout()), this, SLOT(updateCurve()));
}

Temperature *Temperature::getInstance() {
  if (!INSTANCE)
    INSTANCE = new Temperature;

  return INSTANCE;
}

void Temperature::update(QAbstractSeries *series, const int index) {
  // assert(series != Q_NULLPTR);
  // Update data
  if (series->isVisible()) {
    static_cast<QXYSeries *>(series)->replace(m_data[index]);
    // static_cast<QXYSeries *>(series)->replace(P);
  }
}

void Temperature::updateCurve() {
  QPointF pts;
  for (int i = 0; i < 30; i++) {
    QVector<QPointF> Curve = m_data[i];
    int rd = QRandomGenerator::global()->bounded(i, i + 10);
    pts.setX(m_index);
    pts.setY(rd);
    Curve.append(pts);
    m_data[i] = Curve;
    qDebug() << m_data[i];
    m_index++;
  }
}
