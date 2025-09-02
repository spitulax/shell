pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string wday: format("ddd")
    readonly property string day: format("dd")
    readonly property string mon: format("MM")
    readonly property string hour: format("hh")
    readonly property string min: format("mm")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    function format(f: string): string {
        return Qt.formatDateTime(clock.date, f);
    }
}
