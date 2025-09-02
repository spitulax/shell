import QtQuick
import QtQuick.Layouts

ColumnLayout {
    spacing: 0

    Text {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        text: ClockSource.wday
    }
    Text {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        text: ClockSource.day
    }
    Text {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        text: ClockSource.mon
    }
    Text {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        text: ClockSource.hour
    }
    Text {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        text: ClockSource.min
    }
}
