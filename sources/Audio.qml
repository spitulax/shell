pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property real volPercent: fromNode(Pipewire.defaultAudioSink, 0.0, node => node.audio.volume)
    readonly property string volume: Math.round(volPercent * 100)
    readonly property bool muted: fromNode(Pipewire.defaultAudioSink, false, node => node.audio.muted)

    function getIcon(): string {
        if (root.muted) {
            return '󰖁';
        } else {
            const volPercent = Math.round(root.volPercent * 100);
            const icons = ['󰕿', '󰖀', '󰕾'];
            const interval = Math.floor(100 / icons.length);
            for (let i = 0; i < icons.length; ++i) {
                if (volPercent < interval * (i + 1)) {
                    return icons[i];
                }
            }
            return icons[icons.length - 1];
        }
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    function fromNode(node: PwNode, fail: var, f): var {
        return (Pipewire.ready && node) ? f(node) : fail;
    }
}
