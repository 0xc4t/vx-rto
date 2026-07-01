import "../Services"
import QtQuick

Rectangle {
    id: root

    property color backgroundColor: "#313244"
    property color activeColor: "#cdd6f4"
    property color inactiveColor: "#a6adc8"

    width: workspaceRow.implicitWidth + 20
    height: 26
    radius: 13
    color: root.backgroundColor

    function iconForWorkspace(workspaceId, active) {
        if (active)
            return "󱓻";

        switch (workspaceId) {
        case 1:
            return "一";
        case 2:
            return "二";
        case 3:
            return "三";
        case 4:
            return "四";
        case 5:
            return "五";
        case 6:
            return "六";
        case 7:
            return "七";
        case 8:
            return "八";
        case 9:
            return "九";
        case 10:
            return "十";
        default:
            return "";
        }
    }

    WorkspaceService {
        id: wsService
    }

    Row {
        id: workspaceRow

        anchors.centerIn: parent
        spacing: 3

        Repeater {
            model: wsService.model

            Item {
                width: 24
                height: 24
                opacity: empty ? 0.55 : 1

                Text {
                    renderType: Text.NativeRendering
                    font.hintingPreference: Font.PreferFullHinting
                    anchors.centerIn: parent
                    text: root.iconForWorkspace(workspaceId, active)
                    font.family: "Iosevka Nerd Font"
                    font.pixelSize: 14
                    font.weight: Font.Bold
                    color: active ? root.activeColor : root.inactiveColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: wsService.focus(index)
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 120
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
    }
}
