import QtQuick
import QtQuick.Layouts

Rectangle {
    property real margin: 0
    property real sideMargin: 0
    property real thickness: 1

    Layout.fillWidth: true
    Layout.topMargin: margin
    Layout.bottomMargin: margin
    Layout.rightMargin: sideMargin
    Layout.leftMargin: sideMargin
    height: thickness
    color: "black"
}
