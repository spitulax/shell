// TODO: Extra info tooltip
// TODO: Power profile on click (through auto-cpufreq)
import "../utils"
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    readonly property string color: (Battery.isCharging) ? 'green' : 'default'

    spacing: 0

    Text {
        Layout.alignment: Qt.AlignHCenter
        text: Battery.getIcon()
        color: root.color
    }

    Text {
        Layout.alignment: Qt.AlignHCenter
        text: Battery.batInfo
        color: root.color
    }
}
