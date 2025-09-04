pragma Singleton

import qs.utils
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property real volPercent: fromNode(Pipewire.defaultAudioSink, 0.0, node => node.audio.volume)
    readonly property string volume: Math.round(volPercent * 100)
    readonly property bool muted: fromNode(Pipewire.defaultAudioSink, false, node => node.audio.muted)

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    function getIcon(): string {
        if (root.muted) {
            return '󰖁';
        } else {
            return Utils.lerpIcon(['󰕿', '󰖀', '󰕾'], root.volPercent);
        }
    }

    function fromNode(node: PwNode, fail: var, f): var {
        return (Pipewire.ready && node) ? f(node) : fail;
    }
}
