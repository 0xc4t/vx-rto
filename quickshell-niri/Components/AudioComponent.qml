import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    property var volumeService
    property var micService

    function clampedValue(value) {
        return Math.max(0, Math.min(1, value));
    }

    height: 72
    Layout.fillWidth: true

    ColumnLayout {
        anchors.fill: parent
        spacing: 8

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 12

            SharpText {
                Layout.preferredWidth: 20
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.ExtraBold
                text: "󰕾"
                font.pixelSize: 20
                color: "#cdd6f4"
            }

            Slider {
                id: volumeSlider

                Layout.preferredWidth: 224
                from: 0
                to: 1
                stepSize: 0.01
                value: root.clampedValue(root.volumeService ? root.volumeService.volume : 0)
                onMoved: {
                    if (root.volumeService)
                        root.volumeService.setVolume(value);

                }

                background: Rectangle {
                    x: volumeSlider.leftPadding
                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                    width: volumeSlider.availableWidth
                    height: 3
                    radius: 2
                    color: "#45475a"

                    Rectangle {
                        width: volumeSlider.visualPosition * parent.width
                        height: parent.height
                        radius: 2
                        color: "#b4befe"
                    }

                }

                handle: Rectangle {
                    x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                    implicitWidth: 16
                    implicitHeight: 16
                    radius: 8
                    color: "#f5e0dc"
                    border.color: "#b4befe"

                    HoverHandler {
                        cursorShape: Qt.PointingHandCursor
                    }

                }

            }

        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 12

            SharpText {
                Layout.preferredWidth: 20
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.ExtraBold
                text: "󰍬"
                font.pixelSize: 20
                color: "#cdd6f4"
            }

            Slider {
                id: micSlider

                Layout.preferredWidth: 224
                from: 0
                to: 1
                stepSize: 0.01
                value: root.clampedValue(root.micService ? root.micService.volume : 0)
                onMoved: {
                    if (root.micService)
                        root.micService.setVolume(value);

                }

                background: Rectangle {
                    x: micSlider.leftPadding
                    y: micSlider.topPadding + micSlider.availableHeight / 2 - height / 2
                    width: micSlider.availableWidth
                    height: 3
                    radius: 2
                    color: "#45475a"

                    Rectangle {
                        width: micSlider.visualPosition * parent.width
                        height: parent.height
                        radius: 2
                        color: "#f38ba8"
                    }

                }

                handle: Rectangle {
                    x: micSlider.leftPadding + micSlider.visualPosition * (micSlider.availableWidth - width)
                    y: micSlider.topPadding + micSlider.availableHeight / 2 - height / 2
                    implicitWidth: 16
                    implicitHeight: 16
                    radius: 8
                    color: "#f5e0dc"
                    border.color: "#f38ba8"

                    HoverHandler {
                        cursorShape: Qt.PointingHandCursor
                    }

                }

            }

        }

    }

}
