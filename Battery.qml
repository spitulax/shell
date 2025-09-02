// TODO: Extra info tooltip
// TODO: Power profile on click (through auto-cpufreq)
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    readonly property UPowerDevice dev: UPower.displayDevice
    readonly property int state: (dev.ready) ? dev.state : UPowerDeviceState.Unknown
    readonly property real batPercent: (dev.ready) ? dev.percentage : 0.0
    readonly property bool isBattery: dev.ready && dev.type === UPowerDeviceType.Battery
    readonly property string batInfo: (isBattery) ? Math.floor(dev.percentage * 100) : 'DC'
    readonly property bool isCharging: isBattery && !UPower.onBattery
    readonly property string color: (isCharging) ? 'green' : 'default'

    spacing: 0

    Text {
        Layout.alignment: Qt.AlignHCenter
        text: getIcon(batPercent)
        color: root.color
    }

    Text {
        Layout.alignment: Qt.AlignHCenter
        text: batInfo
        color: root.color
    }

    function getIcon(batPercent: real): string {
        if (isBattery) {
            batPercent *= 100;
            const icons = ['', '', '', '', ''];
            const interval = Math.floor(100 / icons.length);
            for (let i = 0; i < icons.length; ++i) {
                if (batPercent < interval * (i + 1)) {
                    return icons[i];
                }
            }
            return icons[icons.length - 1];
        } else {
            return '';
        }
    }
}
