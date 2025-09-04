pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    readonly property list<HyprlandWorkspace> workspaces: Hyprland.workspaces.values
    readonly property list<HyprlandToplevel> windows: Hyprland.toplevels.values
    readonly property string activeWorkspace: {
        const focWs = Hyprland.focusedWorkspace;
        return (focWs) ? focWs.name : '';
    }
    property string activeSpecialWorkspace: ''

    Connections {
        target: Hyprland
        function onRawEvent(event: HyprlandEvent) {
            if (event.name === 'activewindowv2') {
                if (event.data.length > 0) {
                    const activeToplevel = root.windows.find(x => x.address === event.data);
                    root.activeSpecialWorkspace = (activeToplevel && activeToplevel.workspace.id < 0) ? activeToplevel.workspace.name : '';
                } else {
                    root.activeSpecialWorkspace = '';
                }
            } else if (event.name === 'activespecialv2') {
                const args = event.parse(3);
                const id = args[0];
                const name = args[1];
                if (id < 0) {
                    root.activeSpecialWorkspace = name;
                }
            }
        }
    }
}
