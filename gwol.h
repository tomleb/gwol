#ifndef GWOL_H
#define GWOL_H

#include <QObject>

class Gwol : public QObject
{
    Q_OBJECT
public:
    explicit Gwol(QObject *parent = nullptr);


signals:
    void wolFnished(bool success, QString output);
public slots:
    void callWol(QString ipaddr, QString mac, int port = 40000);
};

#endif // GWOL_H
