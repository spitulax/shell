// TODO: Click to open calendar and multi-timezone clock

import "../components"
import "../sources"
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
