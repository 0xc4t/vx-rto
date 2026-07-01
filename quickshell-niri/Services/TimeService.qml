import QtQuick
pragma Singleton

QtObject {
    id: root

    property var current: new Date()
    property Timer ticker

    ticker: Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.current = new Date()
    }

}
