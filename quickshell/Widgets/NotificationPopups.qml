import QtQuick
import Quickshell

Scope {
    id: root

    property var notificationService

    PanelWindow {
        width: root.notificationService && root.notificationService.popupModel.count > 0 ? 360 : 0
        height: root.notificationService && root.notificationService.popupModel.count > 0 ? notifColumn.height : 0
        color: "transparent"

        anchors {
            top: true
            right: true
        }

        margins {
            top: 4
        }

        Column {
            id: notifColumn

            spacing: 10

            Repeater {
                model: root.notificationService ? root.notificationService.popupModel : null

                Rectangle {
                    property int myIndex: index

                    width: 355
                    height: 88
                    color: "#1e1e2e"
                    radius: 16
                    border.width: 2
                    border.color: "#b4befe"
                    clip: true
                    Component.onCompleted: {
                        slideInAnim.start();
                        hideTimer.start();
                        progressAnim.start();
                    }

                    NumberAnimation {
                        id: slideInAnim

                        target: slideTransform
                        property: "x"
                        from: 400
                        to: 0
                        duration: 700
                        easing.type: Easing.OutCubic
                    }

                    SequentialAnimation {
                        id: slideOutAnim

                        NumberAnimation {
                            target: slideTransform
                            property: "x"
                            to: 400
                            duration: 700
                            easing.type: Easing.InCubic
                        }

                        ScriptAction {
                            script: root.notificationService.removePopup(myIndex)
                        }

                    }

                    Timer {
                        id: hideTimer

                        interval: 5000
                        onTriggered: slideOutAnim.start()
                    }

                    Row {
                        anchors.fill: parent
                        anchors.margins: 12
                        anchors.rightMargin: 40
                        anchors.bottomMargin: 18
                        spacing: 12

                        Image {
                            width: 48
                            height: 48
                            source: model.icon
                            fillMode: Image.PreserveAspectFit
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Column {
                            width: parent.width - 60
                            spacing: 4
                            anchors.verticalCenter: parent.verticalCenter

                            Text {
                                renderType: Text.NativeRendering
                                font.hintingPreference: Font.PreferFullHinting
                                font.family: "Iosevka Nerd Font"
                                text: model.summary
                                color: "#cdd6f4"
                                font.pixelSize: 19
                                font.weight: Font.Bold
                                width: parent.width
                                elide: Text.ElideRight
                            }

                            Text {
                                renderType: Text.NativeRendering
                                font.hintingPreference: Font.PreferFullHinting
                                font.family: "Iosevka Nerd Font"
                                font.weight: Font.Bold
                                text: model.body
                                color: "#a6adc8"
                                font.pixelSize: 17
                                width: parent.width
                                wrapMode: Text.WordWrap
                                maximumLineCount: 2
                                elide: Text.ElideRight
                            }

                        }

                    }

                    // Close button
                    Rectangle {
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.margins: 10
                        width: 28
                        height: 28
                        radius: 14
                        color: closeMouseArea.containsMouse ? "#f38ba8" : "transparent"

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            font.family: "Iosevka Nerd Font"
                            font.weight: Font.Bold
                            anchors.centerIn: parent
                            text: "󰅖"
                            color: closeMouseArea.containsMouse ? "#1e1e2e" : "#a6adc8"
                            font.pixelSize: 19
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter

                            Behavior on color {
                                ColorAnimation {
                                    duration: 200
                                }

                            }

                        }

                        MouseArea {
                            id: closeMouseArea

                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                hideTimer.stop();
                                progressAnim.stop();
                                slideOutAnim.start();
                            }
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                            }

                        }

                    }

                    // Progress bar
                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        anchors.bottomMargin: 6
                        height: 2
                        radius: 1.5
                        color: "#313244"

                        Rectangle {
                            id: progressBar

                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            width: parent.width
                            radius: 1.5
                            color: "#b4befe"

                            NumberAnimation {
                                id: progressAnim

                                target: progressBar
                                property: "width"
                                from: progressBar.parent.width
                                to: 0
                                duration: hideTimer.interval
                                easing.type: Easing.Linear
                            }

                        }

                    }

                    transform: Translate {
                        id: slideTransform

                        x: 400
                    }

                }

            }

            move: Transition {
                NumberAnimation {
                    properties: "y"
                    duration: 400
                    easing.type: Easing.OutCubic
                }

            }

            add: Transition {
                NumberAnimation {
                    properties: "y"
                    from: -100
                    duration: 400
                    easing.type: Easing.OutCubic
                }

            }

        }

    }

}
