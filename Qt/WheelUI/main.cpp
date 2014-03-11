#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include "filereader.h"
#include <QtQml/QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setApplicationDisplayName("Wheel UI Home");
    app.setApplicationName("Wheel UI Home");

    QtQuick2ApplicationViewer viewer;

    // Extend functionalities
    FileReader fileReader;
    viewer.rootContext()->setContextProperty("fileReader", &fileReader);

    // Directiories
    QString configDir = "./qml/WheelUI/config/";
    viewer.rootContext()->setContextProperty("configDir", configDir);
    QString imageDir = "./images/";
    viewer.rootContext()->setContextProperty("imageDir", imageDir);

//    viewer.setAttribute(Qt::WA_OpaquePaintEvent);
//    viewer.setAttribute(Qt::WA_NoSystemBackground);
//    viewer.viewport()->setAttribute(Qt::WA_OpaquePaintEvent);
//    viewer.viewport()->setAttribute(Qt::WA_NoSystemBackground);

    viewer.setMainQmlFile(QStringLiteral("qml/WheelUI/main.qml"));
    viewer.setTitle("Default Home Page");
    viewer.showExpanded();
    viewer.showFullScreen();


    return app.exec();
}
