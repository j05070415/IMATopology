import QtQuick 2.7
import QtQuick.Controls 1.4

MenuBar {
    id: root
    Menu {
        title: "文件"
        MenuItem {
            text: "打开"
        }
        MenuItem {
            text: "保存"
        }
        MenuItem {
            text: "另存为"
        }
    }
}
