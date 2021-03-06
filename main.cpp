#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include "QuickQanava.h"
#include "qanFaceNode.h"
#include "FileReadWriter.h"
#include "model/TreeModel.h"

int main(int argc, char *argv[])
{
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("FileOper", new FileReadWriter);
    QuickQanava::initialize(&engine);
    qmlRegisterType< HwaTreeModel >( "TreeModel", 1, 0, "TreeModel");
    qmlRegisterType< qan::FaceNode >( "QuickQanava", 2, 0, "AbstractFaceNode");
    qmlRegisterType< qan::FaceGraph >( "QuickQanava", 2, 0, "FaceGraph");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
