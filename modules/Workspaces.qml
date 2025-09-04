// TODO: Show all windows in workspace on hover

pragma ComponentBehavior: Bound

import "../sources"
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
    }

    Ws {
        special: true
    }

    component Ws: Repeater {
        id: ws

        property bool special: false
        readonly property list<HyprlandWorkspace> workspaces: Workspaces.workspaces.filter(x => !(x.name.startsWith("special:") ^ special))

        model: ScriptModel {
            values: {
                if (!ws.special) {
                    let shownWorkspaces = [];
                    const lastWorkspaceId = (ws.workspaces.length > 0) ? ws.workspaces[ws.workspaces.length - 1].id : 0;
                    for (let i = 1; i <= Math.max(lastWorkspaceId, root.persistentWorkspaces); ++i) {
                        const w = ws.workspaces.find(x => x.id === i);
                        if (i > root.persistentWorkspaces && !w) {
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
                        if (wrapper.modelData === Workspaces.activeSpecialWorkspace) {
                            return '󰝤';
                        } else {
                            return '󰝣';
                        }
                    } else {
                        if (wrapper.modelData === Workspaces.activeWorkspace) {
                            return '󰝥';
                        } else if (Workspaces.workspaces.find(x => x.name === wrapper.modelData)) {
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
