pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    property int persistentWorkspaces: 0

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
        readonly property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values.filter(x => !(x.name.startsWith("special:") ^ special))
        readonly property string activeWorkspace: {
            if (ws.special) {
                // NOTE: Can only detect if the user focuses on a window in the workspace
                const curWs = Hyprland.activeToplevel.workspace;
                return (curWs && curWs.id < 0) ? curWs.name : '';
            } else {
                const focWs = Hyprland.focusedWorkspace;
                return (focWs) ? focWs.name : '';
            }
        }

        model: ScriptModel {
            values: {
                if (!ws.special) {
                    let shownWorkspaces = [];
                    const lastWorkspaceId = ws.workspaces[ws.workspaces.length - 1].id;
                    const max = (lastWorkspaceId > ws.persistentWorkspaces) ? lastWorkspaceId : ws.persistentWorkspaces;
                    for (let i = 1; i <= max; ++i) {
                        const w = ws.workspaces.find(x => x.id === i);
                        if (i > persistentWorkspaces && !w) {
                            continue;
                        }
                        shownWorkspaces.push(i.toString());
                    }
                    return shownWorkspaces;
                } else {
                    return ws.workspaces.map(x => x.name);
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
                    if (ws.special) {
                        if (wrapper.modelData === ws.activeWorkspace) {
                            return '󰝤';
                        } else {
                            return '󰝣';
                        }
                    } else {
                        if (wrapper.modelData === ws.activeWorkspace) {
                            return '󰝥';
                        } else if (ws.workspaces.find(x => x.name === wrapper.modelData)) {
                            return '󰻃';
                        } else {
                            return '󰝦';
                        }
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
