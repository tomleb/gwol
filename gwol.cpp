#include "gwol.h"

#include <QProcess>

Gwol::Gwol(QObject *parent) : QObject(parent)
{

}

void Gwol::callWol(QString ipaddr, QString mac, int port) {
    QString wolExecutable = "wol";
    QStringList args;
    args << "--ipaddr" << ipaddr;
    args << "--port" << QString::number(port);
    args << mac;

    auto process = new QProcess();
    process->start(wolExecutable, args);

    connect(process, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished),
        [=](int exitCode, QProcess::ExitStatus exitStatus){
        QString output;
        bool success = exitCode == 0;
        if (success) {
            output = process->readAll();
        } else {
            output = process->readAllStandardError();
        }
        emit wolFnished(success, output);
        delete(process);
    });
}
