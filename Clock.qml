// TODO: Calendar and multi-timezone info on click

import "components"
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: [ClockSource.wday, ClockSource.day, ClockSource.mon]
    }

    VSeparator {
        sideMargin: 5
    }

    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: [ClockSource.hour, ClockSource.min]
    }
}
