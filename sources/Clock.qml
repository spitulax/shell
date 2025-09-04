pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string wday: astronomicalDay(clock.date)
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

    function astronomicalDay(date: var): string {
        const days = ["日", "月", "火", "水", "木", "金", "土"];
        return days[date.getDay()];
    }
}
