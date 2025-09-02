pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    property int persistentWorkspaces: 0
    property string activeWorkspace: {
        const focWs = Hyprland.focusedWorkspace;
        return (focWs) ? focWs.name : '';
    }
    // NOTE: Can only detect if the user focuses on a window in the workspace
    property string activeSpecialWorkspace: {
        const curWs = Hyprland.activeToplevel.workspace;
        return (curWs && curWs.id < 0) ? curWs.name : '';
    }

    Ws {
        special: false
        persistentWorkspaces: root.persistentWorkspaces
    }

    Ws {
        special: true
    }

    component Ws: Repeater {
        id: ws

        property int persistentWorkspaces: 0

        property bool special: false
        model: ScriptModel {
            values: {
                const workspaces = Hyprland.workspaces.values.filter(x => !(x.name.startsWith("special:") ^ special));
                if (!ws.special) {
                    let shownWorkspaces = [];
                    const lastWorkspaceId = workspaces[workspaces.length - 1].id;
                    const max = (lastWorkspaceId > ws.persistentWorkspaces) ? lastWorkspaceId : ws.persistentWorkspaces;
                    for (let i = 1; i <= max; ++i) {
                        const w = workspaces.find(x => x.id === i);
                        if (i > persistentWorkspaces && !w) {
                            continue;
                        }
                        shownWorkspaces.push(i.toString());
                    }
                    return shownWorkspaces;
                } else {
                    return workspaces.map(x => x.name);
                }
            }
        }

        WrapperMouseArea {
            id: wrapper

            required property string modelData
            property bool active

            cursorShape: Qt.PointingHandCursor

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: {
                    if (wrapper.modelData === root.activeWorkspace || wrapper.modelData === root.activeSpecialWorkspace) {
                        return '󰝥';
                    } else {
                        return (ws.special) ? '󰺕' : '󰝦';
                    }
                }
            }

            onClicked: {
                if (ws.special) {
                    Hyprland.dispatch(`togglespecialworkspace ${wrapper.modelData.substring(8)}`);
                } else {
                    Hyprland.dispatch(`workspace ${wrapper.modelData}`);
                }
            }
        }
    }
}
