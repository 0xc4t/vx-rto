import "../Services"
import QtQuick

Row {
    id: root

    property color textColor: "#cdd6f4"

    BatteryService {
        id: batteryService
    }

    Item {
        width: 24
        height: 24
        anchors.verticalCenter: parent.verticalCenter

        Ring {
            id: batteryRing

            anchors.fill: parent
            ringColor: batteryService.isCharging ? "#a6e3a1" : (batteryService.batteryLevel > 0.2 ? "#b4befe" : "#f38ba8")
            bgColor: "#45475a"
            ringWidth: 3
            value: batteryService.batteryLevel
            showNumber: false
        }

        Text {
            renderType: Text.NativeRendering
            font.hintingPreference: Font.PreferFullHinting
            anchors.centerIn: batteryRing
            text: batteryService.isCharging ? "󰚥" : batteryService.batteryLevel > 0.9 ? "󰁹" : batteryService.batteryLevel > 0.8 ? "󰂂" : batteryService.batteryLevel > 0.7 ? "󰂁" : batteryService.batteryLevel > 0.6 ? "󰂀" : batteryService.batteryLevel > 0.5 ? "󰁿" : batteryService.batteryLevel > 0.4 ? "󰁾" : batteryService.batteryLevel > 0.3 ? "󰁽" : batteryService.batteryLevel > 0.2 ? "󰁼" : batteryService.batteryLevel > 0.1 ? "󰁻" : "󰁺"
            color: root.textColor
            font.pixelSize: 16
            font.family: "Iosevka Nerd Font"
            font.weight: Font.Bold
        }

    }

}
