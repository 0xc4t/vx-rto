import "../Services"
import QtQuick

Row {
    id: root

    property color textColor: "#cdd6f4"
    property bool showRing: true
    property var chargingIcons: ["󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅"]
    property var defaultIcons: ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
    property int iconIndex: Math.max(0, Math.min(9, Math.ceil(batteryService.batteryPercent / 10) - 1))
    property string batteryIcon: (batteryService.isCharging ? chargingIcons : defaultIcons)[iconIndex]

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
            visible: root.showRing
            ringColor: batteryService.isCharging ? "#a6e3a1" : (batteryService.batteryLevel > 0.2 ? "#b4befe" : "#f38ba8")
            bgColor: "#45475a"
            ringWidth: 3
            value: batteryService.batteryLevel
            showNumber: false
        }

        SharpText {
            anchors.centerIn: parent
            text: root.batteryIcon
            color: root.textColor
            font.pixelSize: root.showRing ? 13 : 18
            font.weight: Font.ExtraBold
        }

    }

}
