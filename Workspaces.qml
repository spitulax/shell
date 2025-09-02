pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    Ws {
        special: false
    }

    Ws {
        special: true
    }

    component Ws: Repeater {
        id: ws

        property bool special: false
        // TODO: Persistent workspaces
        model: ScriptModel {
            values: Hyprland.workspaces.values.filter(x => !(x.name.startsWith("special:") ^ special))
        }

        WrapperMouseArea {
            id: wrapper

            required property var modelData
            cursorShape: Qt.PointingHandCursor

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: {
                    if (wrapper.modelData.active) {
                        return '󰝥';
                    } else {
                        return (ws.special) ? '󰺕' : '󰝦';
                    }
                }
            }

            onClicked: {
                if (ws.special) {
                    Hyprland.dispatch(`togglespecialworkspace ${wrapper.modelData.name.substring(8)}`);
                } else {
                    modelData.activate();
                }
            }
        }
    }
}
