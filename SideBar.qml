import Quickshell
import QtQuick
import QtQuick.Layouts

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData
        screen: modelData

        anchors {
            bottom: true
            left: true
            top: true
        }

        implicitWidth: 24

        ColumnLayout {
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
                topMargin: 5
                bottomMargin: 5
            }

            Clock {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
        }
    }
}
