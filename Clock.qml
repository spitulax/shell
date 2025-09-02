import "components"
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    spacing: 0

    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: [ClockSource.wday, ClockSource.day, ClockSource.mon]
    }

    VSeparator {}

    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: [ClockSource.hour, ClockSource.min]
    }
}
