pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root

    readonly property UPowerDevice dev: UPower.displayDevice
    readonly property int state: (dev.ready) ? dev.state : UPowerDeviceState.Unknown
    readonly property real batPercent: (dev.ready) ? dev.percentage : 0.0
    readonly property bool isBattery: dev.ready && dev.type === UPowerDeviceType.Battery
    readonly property string batInfo: (isBattery) ? Math.floor(dev.percentage * 100) : 'DC'
    readonly property bool isCharging: state === UPowerDeviceState.Charging || state === UPowerDeviceState.FullyCharged

    function getIcon(): string {
        if (isBattery) {
            const batPercent = root.batPercent * 100;
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
