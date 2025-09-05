import qs.components
import qs.configs
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

        implicitWidth: BarConfig.sideBarWidth

        ColumnLayout {
            spacing: BarConfig.itemSpacing

            anchors {
                fill: parent
                topMargin: BarConfig.sideMargin
                bottomMargin: BarConfig.sideMargin
            }

            Workspaces {
                Layout.alignment: Qt.AlignHCenter
                persistentWorkspaces: 5
            }

            Filler {}

            NetworkSpeed {
                Layout.alignment: Qt.AlignHCenter
            }

            Stats {
                Layout.alignment: Qt.AlignHCenter
            }

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
