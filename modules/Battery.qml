// TODO: Click to open extra info menu
// TODO: Power profile on click (through auto-cpufreq)

import qs.components
import qs.sources
import QtQuick

VerticalText {
    id: root

    // TODO: Colourscheme
    color: (Battery.isCharging) ? 'green' : ''
    text: [Battery.getIcon(), Battery.batInfo]
}
