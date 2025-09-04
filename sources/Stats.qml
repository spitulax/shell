pragma Singleton

import qs.utils
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property real cpuPerc: 0
    property real cpuLoad: 0
    property real memUsed: 0
    property real memTotal: 0
    readonly property real memPerc: memTotal > 0 ? memUsed / memTotal : 0
    property real storageUsed: 0
    property real storageTotal: 0
    readonly property real storagePerc: storageTotal > 0 ? storageUsed / storageTotal : 0
    property real lastCpuIdle: 0
    property real lastCpuTotal: 0

    readonly property string cpuInfo: Math.round(cpuLoad * 100) / 100
    readonly property string memInfo: Utils.humanReadableUnit(Stats.memUsed, 0, 1)
    readonly property string storageInfo: Utils.humanReadableUnit(Stats.storageUsed, 0, 0)

    property int refCount: 0

    Timer {
        running: root.refCount > 0
        interval: 5000
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            statFile.reload();
            loadavgFile.reload();
            meminfoFile.reload();
            storageProc.running = true;
        }
    }

    FileView {
        id: statFile

        path: "/proc/stat"
        onLoaded: {
            const data = text().match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/);
            if (data) {
                const stats = data.slice(1).map(n => parseInt(n, 10));
                const total = stats.reduce((a, b) => a + b, 0);
                const idle = stats[3] + (stats[4] ?? 0);

                const totalDiff = total - root.lastCpuTotal;
                const idleDiff = idle - root.lastCpuIdle;
                root.cpuPerc = (totalDiff > 0) ? (1 - idleDiff / totalDiff) : 0;

                root.lastCpuTotal = total;
                root.lastCpuIdle = idle;
            }
        }
    }

    FileView {
        id: loadavgFile

        path: "/proc/loadavg"
        onLoaded: {
            const data = text().split(/\s+/);
            root.cpuLoad = parseFloat(data[0], 10) || 0;
        }
    }

    FileView {
        id: meminfoFile

        path: "/proc/meminfo"
        onLoaded: {
            const data = text();
            root.memTotal = parseInt(data.match(/MemTotal: *(\d+)/)[1], 10) || 1;
            root.memUsed = (root.memTotal - parseInt(data.match(/MemAvailable: *(\d+)/)[1], 10)) || 0;
        }
    }

    Process {
        id: storageProc

        command: ["sh", "-c", "df | grep '^/dev/' | awk '{print $1, $3, $4}'"]
        stdout: StdioCollector {
            onStreamFinished: {
                const devices = new Map();

                for (const line of text.trim().split("\n")) {
                    if (line.trim().length <= 0)
                        continue;

                    const parts = line.trim().split(/\s+/);
                    if (parts.length >= 3) {
                        const device = parts[0];
                        const used = parseInt(parts[1], 10) || 0;
                        const avail = parseInt(parts[2], 10) || 0;

                        // Only keep the entry with the largest total space for each device
                        if (!devices.has(device) || (used + avail) > (devices.get(device).used + devices.get(device).avail)) {
                            devices.set(device, {
                                used: used,
                                avail: avail
                            });
                        }
                    }
                }

                let totalUsed = 0;
                let totalAvail = 0;

                for (const [device, stats] of devices) {
                    totalUsed += stats.used;
                    totalAvail += stats.avail;
                }

                root.storageUsed = totalUsed;
                root.storageTotal = totalUsed + totalAvail;
            }
        }
    }
}
