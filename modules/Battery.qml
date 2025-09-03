// TODO: Extra info tooltip
// TODO: Power profile on click (through auto-cpufreq)
import "../components"
import "../utils"
import QtQuick

VerticalText {
    id: root

    // TODO: Colourscheme
    color: (Battery.isCharging) ? 'green' : ''
    text: [Battery.getIcon(), Battery.batInfo]
}
