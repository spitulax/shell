import Quickshell
import QtQuick

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
    }
}
