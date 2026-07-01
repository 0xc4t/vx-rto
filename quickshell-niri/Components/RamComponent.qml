import "../Services"
import QtQuick

Row {
    id: root

    property color textColor: "#cdd6f4"

    RamService {
        id: ramService
    }

    Item {
        width: 24
        height: 24
        anchors.verticalCenter: parent.verticalCenter

        Ring {
            id: ramRing

            anchors.fill: parent
            ringColor: ramService.usage < 0.5 ? "#a6e3a1" : (ramService.usage < 0.8 ? "#b4befe" : "#f38ba8")
            bgColor: "#45475a"
            ringWidth: 3
            value: ramService.usage
            showNumber: false
        }

        SharpText {
            anchors.centerIn: ramRing
            text: "󰍛"
            color: root.textColor
            font.pixelSize: 13
            font.weight: Font.ExtraBold
        }

    }

}
