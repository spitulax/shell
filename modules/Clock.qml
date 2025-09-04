// TODO: Click to open calendar and multi-timezone clock

import qs.components
import qs.sources
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: [Clock.wday, Clock.day, Clock.mon]
    }

    VSeparator {}

    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: [Clock.hour, Clock.min]
    }
}
