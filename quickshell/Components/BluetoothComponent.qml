import "../Services" as Service
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: btRoot

    color: "transparent"

    Service.BluetoothService {
        id: btService
    }

    Flickable {
        anchors.fill: parent
        contentWidth: width
        contentHeight: content.height
        clip: true

        Column {
            id: content

            width: parent.width
            spacing: 12

            Rectangle {
                width: parent.width
                height: 54
                color: "#1e1e2e"
                radius: 12
                border.color: "#313244"
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 10

                    Text {
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        Layout.preferredWidth: 24
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Iosevka Nerd Font"
                        font.weight: Font.Bold
                        text: "󰂯"
                        font.pixelSize: 23
                        color: btService.isPowered ? "#b4befe" : "#585b70"
                    }

                    Column {
                        Layout.fillWidth: true
                        spacing: 1

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            width: parent.width
                            font.family: "Iosevka Nerd Font"
                            text: !btService.isPowered ? "Bluetooth Off" : (btService.isScanning ? "Scanning On" : "Scanning Off")
                            color: "#cdd6f4"
                            font.weight: Font.Bold
                            elide: Text.ElideRight
                        }

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            width: parent.width
                            font.family: "Iosevka Nerd Font"
                            font.weight: Font.Bold
                            text: btService.isPowered ? "Bluetooth Powered" : "Power Off"
                            color: "#a6adc8"
                            font.pixelSize: 12
                            elide: Text.ElideRight
                        }
                    }

                    Rectangle {
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        radius: 10
                        color: "#313244"

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            anchors.centerIn: parent
                            font.family: "Iosevka Nerd Font"
                            font.weight: Font.Bold
                            text: "󰐥"
                            color: btService.isPowered ? "#b4befe" : "#cdd6f4"
                            font.pixelSize: 17
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: btService.togglePower()
                        }
                    }

                    Rectangle {
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 20
                        radius: 10
                        color: !btService.isPowered ? "#313244" : (btService.isScanning ? "#313244" : "#45475a")

                        Rectangle {
                            width: 16
                            height: 16
                            radius: 8
                            color: !btService.isPowered ? "#585b70" : "#ffffff"
                            anchors.verticalCenter: parent.verticalCenter
                            x: btService.isScanning ? 22 : 2

                            Behavior on x {
                                NumberAnimation {
                                    duration: 150
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            enabled: btService.isPowered
                            cursorShape: btService.isPowered ? Qt.PointingHandCursor : Qt.ForbiddenCursor
                            onClicked: btService.toggleScan()
                        }
                    }
                }
            }

            Text {
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                width: parent.width
                leftPadding: 2
                font.family: "Iosevka Nerd Font"
                text: "My Devices"
                color: "#a6adc8"
                font.pixelSize: 15
                font.weight: Font.Bold
                visible: btService.isPowered && btService.pairedDevices.count > 0
            }

            Repeater {
                model: btService.pairedDevices

                delegate: Rectangle {
                    width: content.width
                    height: 58
                    visible: btService.isPowered
                    color: model.connected ? "#313244" : "#1e1e2e"
                    radius: 8
                    border.width: 1
                    border.color: model.connected ? "#a6e3a1" : "#313244"

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        Column {
                            Layout.fillWidth: true
                            spacing: 2

                            Text {
                                renderType: Text.NativeRendering
                                font.hintingPreference: Font.PreferFullHinting
                                width: parent.width
                                font.family: "Iosevka Nerd Font"
                                text: model.name
                                color: "#cdd6f4"
                                font.weight: Font.Bold
                                elide: Text.ElideRight
                            }

                            Text {
                                renderType: Text.NativeRendering
                                font.hintingPreference: Font.PreferFullHinting
                                width: parent.width
                                font.family: "Iosevka Nerd Font"
                                font.weight: Font.Bold
                                text: model.connected ? "Connected" : "Paired"
                                color: model.connected ? "#a6e3a1" : "#6c7086"
                                font.pixelSize: 13
                                elide: Text.ElideRight
                            }
                        }

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            Layout.preferredWidth: 24
                            horizontalAlignment: Text.AlignHCenter
                            font.family: "Iosevka Nerd Font"
                            font.weight: Font.Bold
                            text: model.connected ? "󰅖" : "󰂱"
                            color: model.connected ? "#f38ba8" : "#b4befe"
                            font.pixelSize: 21
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        cursorShape: Qt.PointingHandCursor
                        onClicked: (mouse) => {
                            if (mouse.button === Qt.RightButton) {
                                btService.forgetDevice(model.mac);
                            } else if (model.connected) {
                                btService.disconnectDevice(model.mac);
                            } else {
                                btService.connectDevice(model.mac);
                            }
                        }
                    }
                }
            }

            Text {
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                width: parent.width
                leftPadding: 2
                font.family: "Iosevka Nerd Font"
                text: "Available Devices"
                color: "#a6adc8"
                font.pixelSize: 15
                font.weight: Font.Bold
                visible: btService.isPowered && btService.newDevices.count > 0
            }

            Repeater {
                model: btService.newDevices

                delegate: Rectangle {
                    width: content.width
                    height: 48
                    visible: btService.isPowered
                    color: "#181825"
                    radius: 8
                    border.width: 1
                    border.color: "#313244"

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            Layout.fillWidth: true
                            font.family: "Iosevka Nerd Font"
                            font.weight: Font.Bold
                            text: model.name
                            color: "#a6adc8"
                            elide: Text.ElideRight
                        }

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            font.family: "Iosevka Nerd Font"
                            font.weight: Font.Bold
                            text: "Pair"
                            color: "#b4befe"
                            font.pixelSize: 14
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: btService.pairAndConnect(model.mac)
                    }
                }
            }

            Text {
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                font.family: "Iosevka Nerd Font"
                font.weight: Font.Bold
                visible: !btService.isPowered
                text: "Turn Bluetooth on to manage devices"
                color: "#45475a"
                font.italic: true
            }

            Text {
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                font.family: "Iosevka Nerd Font"
                font.weight: Font.Bold
                visible: btService.isPowered && btService.newDevices.count === 0 && !btService.isScanning
                text: "Turn on scanning to find devices"
                color: "#45475a"
                font.italic: true
            }

            Text {
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                font.family: "Iosevka Nerd Font"
                font.weight: Font.Bold
                visible: btService.isPowered && btService.newDevices.count === 0 && btService.isScanning
                text: "Looking for nearby devices..."
                color: "#6c7086"
                font.italic: true
            }
        }
    }
}
