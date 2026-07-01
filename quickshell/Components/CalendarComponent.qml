import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    property var service
    property int slideOffset: 0

    function triggerNextMonth() {
        exitAnimation.to = -gridContainer.width;
        enterAnimation.from = gridContainer.width;
        slideAnim.callback = function() {
            root.service.nextMonth();
        };
        slideAnim.start();
    }

    function triggerPrevMonth() {
        exitAnimation.to = gridContainer.width;
        enterAnimation.from = -gridContainer.width;
        slideAnim.callback = function() {
            root.service.prevMonth();
        };
        slideAnim.start();
    }

    color: "#1e1e2e"
    radius: 12
    clip: true

    SequentialAnimation {
        id: slideAnim

        property var callback

        NumberAnimation {
            id: exitAnimation

            target: daysGrid
            property: "x"
            duration: 150
            easing.type: Easing.InQuad
        }

        ScriptAction {
            script: slideAnim.callback()
        }

        PropertyAction {
            target: daysGrid
            property: "x"
            value: enterAnimation.from
        }

        NumberAnimation {
            id: enterAnimation

            target: daysGrid
            property: "x"
            to: 0
            duration: 250
            easing.type: Easing.OutCubic
        }

    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        RowLayout {
            Layout.fillWidth: true

            Text {
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                text: root.service ? root.service.monthYearString : ""
                color: "#cdd6f4"
                font.pixelSize: 21
                font.family: "Iosevka Nerd Font"
                font.weight: Font.Bold
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
            }

            Row {
                spacing: 8

                Rectangle {
                    width: 28
                    height: 28
                    radius: 6
                    color: "#313244"

                    Text {
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        anchors.centerIn: parent
                        text: "←"
                        color: "#cdd6f4"
                        font.family: "Iosevka Nerd Font"
                        font.weight: Font.Bold
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.triggerPrevMonth()
                        cursorShape: Qt.PointingHandCursor
                    }

                }

                Rectangle {
                    width: 28
                    height: 28
                    radius: 6
                    color: "#313244"

                    Text {
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        anchors.centerIn: parent
                        text: "→"
                        color: "#cdd6f4"
                        font.family: "Iosevka Nerd Font"
                        font.weight: Font.Bold
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.triggerNextMonth()
                        cursorShape: Qt.PointingHandCursor
                    }

                }

            }

        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 0

            Repeater {
                model: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]

                Item {
                    Layout.fillWidth: true
                    height: 20

                    Text {
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        anchors.centerIn: parent
                        text: modelData
                        color: "#6c7086"
                        font.pixelSize: 15
                        font.family: "Iosevka Nerd Font"
                        font.weight: Font.Bold
                    }

                }

            }

        }

        Item {
            id: gridContainer

            Layout.fillWidth: true
            Layout.fillHeight: true

            GridLayout {
                id: daysGrid

                width: parent.width
                height: parent.height
                columns: 7
                rows: 6
                columnSpacing: 4
                rowSpacing: 4

                Repeater {
                    model: root.service ? root.service.gridModel : null

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: 8
                        color: {
                            if (model.isToday)
                                return "#b4befe";

                            if (!model.isCurrentMonth)
                                return "transparent";

                            return hoverHandler.hovered ? "#313244" : "transparent";
                        }

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            anchors.centerIn: parent
                            text: model.dayNumber
                            font.pixelSize: 17
                            font.family: "Iosevka Nerd Font"
                            font.weight: Font.Bold
                            color: {
                                if (model.isToday)
                                    return "#1e1e2e";

                                if (model.isCurrentMonth)
                                    return "#cdd6f4";

                                return "#45475a";
                            }
                        }

                        HoverHandler {
                            id: hoverHandler

                            enabled: model.isCurrentMonth
                        }

                    }

                }

            }

        }

    }

}
