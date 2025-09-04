// TODO: More detailed info on click

import qs.components
import qs.sources
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    VerticalText {
        text: ["󰋊", Stats.storageInfo]
    }

    VSeparator {}

    VerticalText {
        text: ["󰘚", Stats.memInfo]
    }

    VSeparator {}

    VerticalText {
        text: ["󰍛", Stats.cpuInfo]
    }

    Ref {
        source: Stats
    }
}
