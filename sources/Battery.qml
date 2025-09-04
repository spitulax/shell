pragma Singleton

import qs.utils
import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root

    readonly property UPowerDevice dev: UPower.displayDevice
    readonly property int state: (dev.ready) ? dev.state : UPowerDeviceState.Unknown
    readonly property real batPercent: (dev.ready) ? dev.percentage : 0.0
    readonly property bool isBattery: dev.ready && dev.type === UPowerDeviceType.Battery
    readonly property string batInfo: (isBattery) ? Math.round(dev.percentage * 100) : 'DC'
    readonly property bool isCharging: state === UPowerDeviceState.Charging || state === UPowerDeviceState.FullyCharged

    function getIcon(): string {
        if (isBattery) {
            return Utils.lerpIcon(['', '', '', '', ''], root.batPercent);
        } else {
            return '';
        }
    }
}
