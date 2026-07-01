import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    property var service

    height: 40
    Layout.fillWidth: true

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 12

        SharpText {
            Layout.preferredWidth: 20
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.ExtraBold
            text: "󰃞"
            font.pixelSize: 20
            color: "#cdd6f4"
        }

        Slider {
            id: slider

            Layout.preferredWidth: 225
            from: 0
            to: 100
            value: root.service ? root.service.percentage : 0
            onMoved: {
                if (root.service)
                    root.service.setBrightness(value);

            }

            background: Rectangle {
                x: slider.leftPadding
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                implicitWidth: 200
                implicitHeight: 3
                width: slider.availableWidth
                height: implicitHeight
                radius: 2
                color: "#45475a"

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }

                Rectangle {
                    width: slider.visualPosition * parent.width
                    height: parent.height
                    color: "#b4befe"
                    radius: 2
                }

            }

            handle: Rectangle {
                id: handleRect

                x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                implicitWidth: 16
                implicitHeight: 16
                radius: 8
                color: "#f5e0dc"
                border.color: "#b4befe"

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }

                Rectangle {
                    id: bubble

                    visible: slider.pressed
                    z: 100
                    width: 20
                    height: 20
                    radius: 4
                    color: "#1e1e2e"
                    x: (parent.width - width) / 2
                    y: -height - 8

                    SharpText {
                        anchors.centerIn: parent
                        text: Math.round(slider.value)
                        font.pixelSize: 12
                        font.weight: Font.ExtraBold
                        color: "#cdd6f4"
                    }

                    Rectangle {
                        width: 6
                        height: 6
                        rotation: 45
                        color: "#1e1e2e"
                        x: (parent.width - width) / 2
                        y: parent.height - 3
                        z: -1
                    }

                }

            }

        }

    }

}
