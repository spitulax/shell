// TODO: Calendar and multi-timezone info on click

import "../components"
import "../utils"
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: [Clock.wday, Clock.day, Clock.mon]
    }

    VSeparator {
        sideMargin: 5
    }

    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: [Clock.hour, Clock.min]
    }
}
