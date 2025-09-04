pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    required property list<string> text
    property int alignment: Qt.AlignHCenter
    property string color

    spacing: 0

    Repeater {
        model: root.text

        Text {
            required property string modelData
            Layout.alignment: root.alignment
            text: modelData
            color: root.color
        }
    }
}
