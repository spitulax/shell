import "../components"
import Quickshell
import QtQuick
import QtQuick.Layouts

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property ShellScreen modelData
        screen: modelData

        anchors {
            bottom: true
            left: true
            top: true
        }

        implicitWidth: 32

        ColumnLayout {
            spacing: 10

            anchors {
                top: parent.top
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: 5
                bottomMargin: 5
            }

            Workspaces {
                Layout.alignment: Qt.AlignHCenter
                persistentWorkspaces: 5
            }

            VFiller {}

            Audio {
                Layout.alignment: Qt.AlignHCenter
            }

            Battery {
                Layout.alignment: Qt.AlignHCenter
            }

            Clock {
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
