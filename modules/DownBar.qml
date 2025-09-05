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
            right: true
        }

        implicitHeight: BarConfig.downBarHeight

        RowLayout {
            spacing: BarConfig.itemSpacing

            anchors {
                fill: parent
                leftMargin: BarConfig.sideMargin
                rightMargin: BarConfig.sideMargin
            }

            Filler {}

            WindowTitle {
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
