import Quickshell
import QtQuick

QtObject {
    required property Singleton source

    Component.onCompleted: source.refCount++
    Component.onDestruction: source.refCount--
}
