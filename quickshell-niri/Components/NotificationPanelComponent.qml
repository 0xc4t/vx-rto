import QtQuick
import QtQuick.Layouts

Rectangle {
    id: notificationPanel

    property var notificationService
    property var notificationModel
    readonly property var activeNotificationModel: notificationService ? notificationService.notificationModel : notificationModel

    function removeAt(index) {
        if (notificationService) {
            notificationService.removeNotification(index);
            return;
        }

        if (activeNotificationModel && index >= 0 && index < activeNotificationModel.count)
            activeNotificationModel.remove(index);

    }

    color: "transparent"

    Rectangle {
        id: dndToggle

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 12
        height: 58
        color: "#1e1e2e"
        radius: 12
        border.width: 1
        border.color: notificationPanel.notificationService && notificationPanel.notificationService.doNotDisturb ? "#f38ba8" : "#313244"

        RowLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 10

            Rectangle {
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                radius: 18
                color: notificationPanel.notificationService && notificationPanel.notificationService.doNotDisturb ? "#f38ba8" : "#313244"

                SharpText {
                    anchors.centerIn: parent
                    font.weight: Font.ExtraBold
                    text: notificationPanel.notificationService && notificationPanel.notificationService.doNotDisturb ? "󰂛" : "󰂚"
                    color: notificationPanel.notificationService && notificationPanel.notificationService.doNotDisturb ? "#1e1e2e" : "#cdd6f4"
                    font.pixelSize: 20
                }

            }

            Column {
                Layout.fillWidth: true
                spacing: 2

                SharpText {
                    width: parent.width
                    font.weight: Font.ExtraBold
                    text: "Do Not Disturb"
                    color: "#cdd6f4"
                    font.pixelSize: 15
                    elide: Text.ElideRight
                }

                SharpText {
                    width: parent.width
                    font.weight: Font.ExtraBold
                    text: notificationPanel.notificationService && notificationPanel.notificationService.doNotDisturb ? "Popups muted" : "Notifications on"
                    color: notificationPanel.notificationService && notificationPanel.notificationService.doNotDisturb ? "#f38ba8" : "#a6adc8"
                    font.pixelSize: 12
                    elide: Text.ElideRight
                }

            }

            Rectangle {
                Layout.preferredWidth: 40
                Layout.preferredHeight: 22
                radius: 11
                color: notificationPanel.notificationService && notificationPanel.notificationService.doNotDisturb ? "#f38ba8" : "#45475a"

                Rectangle {
                    width: 18
                    height: 18
                    radius: 9
                    color: notificationPanel.notificationService && notificationPanel.notificationService.doNotDisturb ? "#1e1e2e" : "#cdd6f4"
                    anchors.verticalCenter: parent.verticalCenter
                    x: notificationPanel.notificationService && notificationPanel.notificationService.doNotDisturb ? 20 : 2

                    Behavior on x {
                        NumberAnimation {
                            duration: 150
                        }

                    }

                }

            }

        }

        MouseArea {
            anchors.fill: parent
            enabled: notificationPanel.notificationService
            cursorShape: notificationPanel.notificationService ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: notificationPanel.notificationService.toggleDoNotDisturb()
        }

        Behavior on border.color {
            ColorAnimation {
                duration: 200
            }

        }

    }

    Flickable {
        id: listArea

        anchors.top: dndToggle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 12
        clip: true
        contentWidth: width
        contentHeight: notifColumn.height
        boundsBehavior: Flickable.StopAtBounds

        Column {
            id: notifColumn

            width: parent.width
            spacing: 12

            Repeater {
                model: notificationPanel.activeNotificationModel

                delegate: Rectangle {
                    id: notifCard

                    property int myIndex: index

                    width: parent.width
                    height: 90
                    color: "#1e1e2e"
                    radius: 12

                    // Fade out animation
                    SequentialAnimation {
                        id: fadeOutAnim

                        NumberAnimation {
                            target: notifCard
                            property: "opacity"
                            to: 0
                            duration: 200
                            easing.type: Easing.InOutQuad
                        }

                        NumberAnimation {
                            target: notifCard
                            property: "height"
                            to: 0
                            duration: 100
                            easing.type: Easing.InOutQuad
                        }

                        ScriptAction {
                            script: notificationPanel.removeAt(notifCard.myIndex)
                        }

                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 12

                        Rectangle {
                            Layout.preferredWidth: 48
                            Layout.preferredHeight: 48
                            color: "transparent"

                            Image {
                                anchors.fill: parent
                                source: model.icon
                                fillMode: Image.PreserveAspectFit
                                sourceSize.width: 48
                                sourceSize.height: 48
                                onStatusChanged: {
                                    if (status === Image.Error)
                                        visible = false;

                                }
                            }

                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            spacing: 4

                            SharpText {
                                text: model.summary
                                color: "#cdd6f4"
                                font.pixelSize: 18
                                font.weight: Font.ExtraBold
                                Layout.fillWidth: true
                                elide: Text.ElideRight
                            }

                            SharpText {
                                font.weight: Font.ExtraBold
                                text: model.body
                                color: "#a6adc8"
                                font.pixelSize: 16
                                wrapMode: Text.WordWrap
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                elide: Text.ElideRight
                                maximumLineCount: 2
                            }

                        }

                        Rectangle {
                            Layout.preferredWidth: 24
                            Layout.preferredHeight: 24
                            Layout.alignment: Qt.AlignTop
                            color: closeMouseArea.containsMouse ? "#f38ba8" : "#313244"
                            radius: 14

                            SharpText {
                                anchors.centerIn: parent
                                anchors.verticalCenterOffset: 1
                                text: "✕"
                                color: closeMouseArea.containsMouse ? "#1e1e2e" : "#cdd6f4"
                                font.pixelSize: 16
                                font.weight: Font.ExtraBold
                            }

                            MouseArea {
                                id: closeMouseArea

                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    fadeOutAnim.start();
                                }
                            }

                            Behavior on color {
                                ColorAnimation {
                                    duration: 200
                                }

                            }

                        }

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

        }

    }

    SharpText {
        font.weight: Font.ExtraBold
        anchors.centerIn: listArea
        text: "No notifications"
        color: "#6c7086"
        font.pixelSize: 18
        visible: notificationPanel.activeNotificationModel.count === 0
    }

}
