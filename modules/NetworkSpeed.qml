// TODO: Open network menu on click, the same network menu as the Wifi icon's

import qs.components
import qs.sources
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: ["󰕒", Network.upInfo]
    }

    VSeparator {}

    VerticalText {
        Layout.alignment: Qt.AlignHCenter
        text: ["󰇚", Network.downInfo]
    }

    Ref {
        source: Network
    }
}
