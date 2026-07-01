import "../Services"
import QtQuick

Row {
    id: root

    property color textColor: "#cdd6f4"

    CpuService {
        id: cpuService
    }

    Item {
        width: 24
        height: 24
        anchors.verticalCenter: parent.verticalCenter

        Ring {
            id: cpuRing

            anchors.fill: parent
            ringColor: cpuService.usage < 0.5 ? "#a6e3a1" : (cpuService.usage < 0.8 ? "#b4befe" : "#f38ba8")
            bgColor: "#45475a"
            ringWidth: 3
            value: cpuService.usage
            showNumber: false
        }

        Text {
            renderType: Text.NativeRendering
            font.hintingPreference: Font.PreferFullHinting
            anchors.centerIn: cpuRing
            text: "󰘚"
            color: root.textColor
            font.pixelSize: 16
            font.family: "Iosevka Nerd Font"
            font.weight: Font.Bold
        }

    }

}
