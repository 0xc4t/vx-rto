import "../Services" as Service
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: btRoot

    width: 320
    height: 450
    color: "transparent"

    Service.BluetoothService {
        id: btService
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        Rectangle {
            Layout.fillWidth: true
            height: 50
            color: "#1e1e2e"
            radius: 12
            border.color: btService.isPowered ? "#b4befe" : "#313244"
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 10

                SharpText {
                    font.weight: Font.ExtraBold
                    text: "󰂯"
                    font.pixelSize: 24
                    color: btService.isPowered ? "#b4befe" : "#585b70"
                }

                Column {
                    Layout.fillWidth: true

                    SharpText {
                        text: btService.isScanning ? "Scanning On" : "Scanning Off"
                        color: "#cdd6f4"
                        font.weight: Font.ExtraBold
                    }

                    SharpText {
                        font.weight: Font.ExtraBold
                        text: btService.isPowered ? "Bluetooth Powered" : "Power Off"
                        color: "#a6adc8"
                        font.pixelSize: 12
                    }

                }

                Rectangle {
                    width: 40
                    height: 20
                    radius: 10
                    color: !btService.isPowered ? "#313244" : (btService.isScanning ? "#b4befe" : "#45475a")

                    Rectangle {
                        width: 16
                        height: 16
                        radius: 8
                        color: !btService.isPowered ? "#585b70" : "white"
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

        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: btService.isPowered
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: 15

                SharpText {
                    text: "My Devices"
                    color: "#a6adc8"
                    font.pixelSize: 14
                    font.weight: Font.ExtraBold
                    visible: btService.pairedDevices.count > 0
                }

                Repeater {
                    model: btService.pairedDevices

                    delegate: Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 50
                        color: model.connected ? "#313244" : "#1e1e2e"
                        radius: 8
                        border.width: 1
                        border.color: model.connected ? "#a6e3a1" : "#313244"

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10

                            Column {
                                Layout.fillWidth: true

                                SharpText {
                                    text: model.name
                                    color: "#cdd6f4"
                                    font.weight: Font.ExtraBold
                                    elide: Text.ElideRight
                                    width: parent.width
                                }

                                SharpText {
                                    font.weight: Font.ExtraBold
                                    text: model.connected ? "Connected" : "Paired"
                                    color: model.connected ? "#a6e3a1" : "#6c7086"
                                    font.pixelSize: 12
                                }

                            }

                            SharpText {
                                font.weight: Font.ExtraBold
                                text: model.connected ? "󰅖" : "󰂱"
                                color: model.connected ? "#f38ba8" : "#b4befe"
                                font.pixelSize: 20
                            }

                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            cursorShape: Qt.PointingHandCursor
                            onClicked: (mouse) => {
                                if (mouse.button === Qt.RightButton) {
                                    btService.forgetDevice(model.mac);
                                } else {
                                    if (model.connected)
                                        btService.disconnectDevice(model.mac);
                                    else
                                        btService.connectDevice(model.mac);
                                }
                            }
                        }

                    }

                }

                SharpText {
                    text: "Available Devices"
                    color: "#a6adc8"
                    font.pixelSize: 14
                    font.weight: Font.ExtraBold
                    visible: btService.newDevices.count > 0
                }

                Repeater {
                    model: btService.newDevices

                    delegate: Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 45
                        color: "#181825"
                        radius: 8

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10

                            SharpText {
                                font.weight: Font.ExtraBold
                                text: model.name
                                color: "#a6adc8"
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            SharpText {
                                font.weight: Font.ExtraBold
                                text: "Pair"
                                color: "#b4befe"
                                font.pixelSize: 13
                            }

                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: btService.pairAndConnect(model.mac)
                        }

                    }

                }

                SharpText {
                    font.weight: Font.ExtraBold
                    visible: btService.newDevices.count === 0 && !btService.isScanning
                    text: "Turn on scanning to find devices"
                    color: "#45475a"
                    font.italic: true
                    Layout.alignment: Qt.AlignHCenter
                }

            }

        }

    }

}
