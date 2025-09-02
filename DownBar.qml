import Quickshell
import QtQuick

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property var modelData
        screen: this.modelData

        anchors {
            bottom: true
            left: true
            right: true
        }

        implicitHeight: 24
    }
}
