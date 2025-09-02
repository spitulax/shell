pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    default required property list<string> text
    property int alignment: Qt.AlignHCenter | Qt.AlignVCenter

    spacing: 0

    Repeater {
        model: root.text

        Text {
            required property var modelData
            Layout.alignment: root.alignment
            text: this.modelData
        }
    }
}
