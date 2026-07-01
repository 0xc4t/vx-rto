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
    signal toggleDateCenter()

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
        color: "#11111b"
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
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            Rectangle {
                width: 34
                height: 26
                radius: 13
                color: "#313244"

                Text {
                    renderType: Text.NativeRendering
                    font.hintingPreference: Font.PreferFullHinting
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 1
                    text: "󰣇"
                    color: "#cdd6f4"
                    font.family: "Iosevka Nerd Font"
                    font.weight: Font.Bold
                    font.pixelSize: 16
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Quickshell.execDetached(["kitty", "-e", "zsh", "-lc", "fastfetch; exec zsh"])
                }
            }

            WorkspaceComponent {
                anchors.verticalCenter: parent.verticalCenter
            }

            TrayComponent {
                anchors.verticalCenter: parent.verticalCenter
                panelWindow: panel
            }

        }

        // --- Center Area ---
        Row {
            anchors.centerIn: parent
            spacing: 2

            TimeComponent {
                onClicked: panel.toggleDateCenter()
            }

        }

        // --- Right Side ---
        Row {
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            BatteryComponent {
            }

            CpuComponent {
            }

            RamComponent {
            }

            Rectangle {
                width: iconsRow.width + 20
                height: 26
                radius: 13
                color: "#313244"

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

                    Text {
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        font.family: "Iosevka Nerd Font"
                        font.weight: Font.Bold
                        text: "󰂚"
                        color: "#cdd6f4"
                        font.pixelSize: 16
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        font.family: "Iosevka Nerd Font"
                        font.weight: Font.Bold
                        text: "󰖩"
                        color: "#cdd6f4"
                        font.pixelSize: 16
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        font.family: "Iosevka Nerd Font"
                        font.weight: Font.Bold
                        text: "󰂯"
                        color: "#cdd6f4"
                        font.pixelSize: 16
                        anchors.verticalCenter: parent.verticalCenter
                    }

                }

            }

        }

    }

}
