pragma Singleton

import Quickshell

Singleton {
    function lerpIcon(icons: list<string>, t: real): string {
        const interval = 1.0 / icons.length;
        for (let i = 0; i < icons.length; ++i) {
            if (t < interval * (i + 1)) {
                return icons[i];
            }
        }
        return icons[icons.length - 1];
    }

    // level: 0=KB, 1=MB, ...
    function humanReadableUnit(n: real, level: int, rounding: int): string {
        const units = ["K", "M", "G", "T"];
        let i = 0, on = 0;
        for (; n >= 1 && i + level < units.length; n /= 1024) {
            on = n;
            ++i;
        }
        return `${Math.round(on * Math.pow(10, rounding)) / Math.pow(10, rounding)}${units[i - 1 + level]}`;
    }
}
