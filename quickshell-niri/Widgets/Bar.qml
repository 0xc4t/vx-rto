import "../Components"
import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: panel

    property color bgColor
    property color surfaceColor: "#cdd6f4"
    property color textColor: "#cdd6f4"
    property bool sidebarVisible: false

    signal toggleSidebar()

    height: 40
    color: "transparent"
    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "bar"
    WlrLayershell.exclusiveZone: 40

    anchors {
        top: true
        left: true
        right: true
    }

    Rectangle {
        anchors.fill: parent
        color: "#000000"
    }

    Rectangle {
        id: statusBar

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 40
        color: panel.bgColor
        radius: 18

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: parent.radius
            color: panel.bgColor
        }

        // --- Left Side ---
        Row {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            WorkspaceComponent {
                anchors.verticalCenter: parent.verticalCenter
            }

        }

        // --- Center Area ---
        Row {
            anchors.centerIn: parent
            spacing: 2

            TimeComponent {
            }

        }

        // --- Right Side ---
        Row {
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            Rectangle {
                width: iconsRow.width + 20
                height: 26
                radius: 13
                color: "#1e1e2e"

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        panel.toggleSidebar();
                    }
                }

                Row {
                    id: iconsRow

                    anchors.centerIn: parent
                    spacing: 8

                    BatteryComponent {
                        width: 24
                        height: 24
                        anchors.verticalCenter: parent.verticalCenter
                        textColor: "#cdd6f4"
                        showRing: false
                    }

                    SharpText {
                        font.weight: Font.ExtraBold
                        text: "󰂚"
                        color: "#cdd6f4"
                        font.pixelSize: 18
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    SharpText {
                        font.weight: Font.ExtraBold
                        text: "󰖩"
                        color: "#cdd6f4"
                        font.pixelSize: 18
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    SharpText {
                        font.weight: Font.ExtraBold
                        text: "󰂯"
                        color: "#cdd6f4"
                        font.pixelSize: 18
                        anchors.verticalCenter: parent.verticalCenter
                    }

                }

            }

        }

    }

}
