import QtQuick
import QtQuick.Layouts

Rectangle {
    property real margin: 5
    property real sideMargin: 2
    property real thickness: 1

    Layout.fillWidth: true
    Layout.topMargin: this.margin
    Layout.bottomMargin: this.margin
    Layout.rightMargin: this.sideMargin
    Layout.leftMargin: this.sideMargin
    height: this.thickness
    color: "black"
}
