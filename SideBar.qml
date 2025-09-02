import "components"
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

        implicitWidth: 32

        ColumnLayout {
            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 5
                bottomMargin: 5
            }

            Workspaces {
                Layout.alignment: Qt.AlignHCenter
            }

            VFiller {}

            Clock {
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
