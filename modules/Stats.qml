// TODO: More detailed info on click

import qs.components
import qs.sources
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: ["󰋊", Stats.storageInfo]
    }

    VSeparator {}

    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: ["󰘚", Stats.memInfo]
    }

    VSeparator {}

    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: ["󰍛", Stats.cpuInfo]
    }

    Ref {
        source: Stats
    }
}
