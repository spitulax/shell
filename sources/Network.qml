pragma Singleton

import qs.configs
import qs.utils
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property int timerInterval: TimerConfig.interval
    property string activeInterface: ""
    property int curUp: 0
    property int curDown: 0
    property int prevUp: 0
    property int prevDown: 0
    property int upPerSec: 0
    property int downPerSec: 0

    property string upInfo: Utils.humanReadableUnit(root.upPerSec, 0, 1)
    property string downInfo: Utils.humanReadableUnit(root.downPerSec, 0, 1)

    property int refCount: 0

    Timer {
        running: root.refCount > 0
        interval: root.timerInterval
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            deviceStateProc.running = true;
        }
    }

    Process {
        id: deviceStateProc

        command: ["nmcli", "-t", "-f", "DEVICE", "connection", "show", "--active"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.activeInterface = text.split("\n")[0];
                netDevFile.reload();
            }
        }
    }

    FileView {
        id: netDevFile

        path: "/proc/net/dev"
        onLoaded: {
            if (root.activeInterface.length > 0) {
                // hopefully the interface name doesn't confuse regex...
                const regex = new RegExp(`${root.activeInterface}.*`);
                const data = (text().match(regex) ?? [""])[0];
                if (data.length > 0) {
                    const filterEmpty = value => value !== "";
                    const lineData = data.split(" ").filter(filterEmpty);
                    const upBytes = Number.parseInt(lineData[9]);
                    const downBytes = Number.parseInt(lineData[1]);
                    root.curUp = upBytes;
                    root.curDown = downBytes;
                    if (root.prevUp + root.prevDown !== 0) {
                        root.upPerSec = (root.curUp - root.prevUp) / (root.timerInterval / 1000);
                        root.downPerSec = (root.curDown - root.prevDown) / (root.timerInterval / 1000);
                    }
                    root.prevUp = upBytes;
                    root.prevDown = downBytes;
                }
            }
        }
    }
}
