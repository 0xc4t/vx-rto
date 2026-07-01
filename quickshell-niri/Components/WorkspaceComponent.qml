import "../Services"
import QtQuick

        Row {
    id: root

    property int lastActiveIndex: 0
    property int spinDirection: 1

    spacing: 15

    WorkspaceService {
        id: wsService

        onActiveIndexChanged: {
            if (wsService.activeIndex > root.lastActiveIndex)
                root.spinDirection = 1;
            else
                root.spinDirection = -1;
            root.lastActiveIndex = wsService.activeIndex;
        }
    }

    Rectangle {
        width: (wsService.model.count * 30) + 4
        height: 32
        radius: 16
        color: "#1e1e2e"
        anchors.verticalCenter: parent.verticalCenter

        Row {
            id: workspaceRow

            anchors.fill: parent
            anchors.leftMargin: 3
            spacing: 4

            Repeater {
                model: wsService.model

                Rectangle {
                    width: 26
                    height: 26
                    color: "transparent"
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        anchors.centerIn: parent
                        width: active ? 12 : 8
                        height: active ? 12 : 8
                        radius: width / 2
                        color: active ? "#cdd6f4" : "#585b70"
                        opacity: active ? 1 : 0.7
                    }

                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -4
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: wsService.focus(index)
                    }

                }

            }

        }

        Behavior on width {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }

        }

    }

    SharpText {
        text: "Workspace " + (wsService.activeIndex + 1)
        font.pixelSize: 16
        font.weight: Font.ExtraBold
        color: "#cdd6f4"
        anchors.verticalCenter: parent.verticalCenter
        elide: Text.ElideRight
        maximumLineCount: 1
        width: 300
    }

}
