import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

ApplicationWindow {
    title: qsTr("Quick Keep")
    width: 640
    height: 480
    visible: true

    menuBar: MenuBar {
        Menu {
            id: helpMenu
            title: qsTr("Menu")

            MenuItem {
                text: qsTr("About")
                onTriggered: stackView.push(Qt.resolvedUrl("About.qml"))
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit()
            }
        }
    }

    toolBar: ToolBar {
        RowLayout {
            ToolButton {
                text: "back"
                visible: stackView.depth > 1
                onClicked: stackView.pop()
            }
            anchors.fill: parent
            anchors.margins: spacing
            Label {
                text: stackView.currentItem ? stackView.currentItem.title : ""
            }
            Item { Layout.fillWidth: true }
            CheckBox {
                id: enabler
                text: "Enabled"
                checked: true
            }
        }
    }

    Component {
        id: mainForm
        MainForm {
            button1.onClicked: stackView.push(mainForm)
            button2.onClicked: stackView.pop()
        }
    }

    StackView {
        id: stackView
        initialItem: mainForm

        focus: true

        Keys.onPressed: {
            if (event.key === Qt.Key_Back)
            {
                if (stackView.depth > 1) {
                    console.log("<d8d1935a> Back pressed")
                    stackView.pop()
                    event.accepted = true
                }
            }

        }

        Keys.onMenuPressed: {
            helpMenu.popup()
        }
    }

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
}
