import qs.configs
import QtQuick
import QtQuick.Layouts

Rectangle {
    property real margin: 0
    property real thickness: 1

    Layout.alignment: Qt.AlignHCenter
    Layout.topMargin: margin
    Layout.bottomMargin: margin
    implicitWidth: Math.round(BarConfig.sideBarWidth * 0.5)
    height: thickness
    // TODO: Colourscheme
    color: "black"
}
