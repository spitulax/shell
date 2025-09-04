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
    property HyprlandToplevel activeWindow: null
    readonly property string activeWindowTitle: (root.activeWindow) ? root.activeWindow.title : "Desktop"

    Connections {
        target: Hyprland
        function onRawEvent(event: HyprlandEvent) {
            if (event.name === 'activewindowv2') {
                if (event.data.length > 0) {
                    root.activeWindow = root.windows.find(x => x.address === event.data);
                    root.activeSpecialWorkspace = (root.activeWindow && root.activeWindow.workspace.id < 0) ? root.activeWindow.workspace.name : '';
                } else {
                    root.activeWindow = null;
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
