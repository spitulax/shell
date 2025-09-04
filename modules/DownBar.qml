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

        implicitHeight: 24

        RowLayout {
            spacing: 10

            anchors {
                left: parent.left
                right: parent.right
                verticalCenter: parent.verticalCenter
                leftMargin: BarConfig.sideMargin
                rightMargin: BarConfig.sideMargin
            }

            HFiller {}

            WindowTitle {
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }
}
