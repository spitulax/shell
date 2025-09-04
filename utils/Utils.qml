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
}
