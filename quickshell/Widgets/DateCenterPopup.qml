import "../Services" as Services
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: popup

    readonly property color mochaCrust: "#11111b"
    readonly property color mochaMantle: "#181825"
    readonly property color mochaBase: "#1e1e2e"
    readonly property color mochaSurface0: "#313244"
    readonly property color mochaSurface2: "#585b70"
    readonly property color mochaText: "#cdd6f4"
    readonly property color mochaSubtext0: "#a6adc8"
    readonly property color mochaLavender: "#b4befe"

    signal requestClose()

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    focusable: true
    implicitHeight: 320
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
    onVisibleChanged: {
        if (visible)
            Qt.callLater(() => island.forceActiveFocus());

    }

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    Services.MprisService {
        id: mprisService
    }

    Services.CalendarService {
        id: calendarService
    }

    function seconds(value) {
        if (!value || value < 0)
            return 0;

        return value > 100000 ? value / 1000000 : value;
    }

    function progressRatio() {
        progressMarker.progressTick;
        if (!mprisService.activePlayer || !mprisService.activePlayer.lengthSupported)
            return 0;

        let length = popup.seconds(mprisService.activePlayer.length);
        if (length <= 0)
            return 0;

        return Math.max(0, Math.min(1, popup.seconds(mprisService.activePlayer.position) / length));
    }

    function offsetDate(offset) {
        let date = new Date(Services.TimeService.current);
        date.setDate(date.getDate() + offset);
        return date;
    }

    Timer {
        interval: 1000
        running: popup.visible && mprisService.hasPlayers
        repeat: true
        onTriggered: progressMarker.progressTick++
    }

    Item {
        id: progressMarker

        property int progressTick: 0
    }

    MouseArea {
        anchors.fill: parent
        onClicked: popup.requestClose()
    }

    Rectangle {
        id: island

        width: Math.min(parent.width - 32, 720)
        height: 228
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 44
        radius: 36
        color: popup.mochaCrust
        border.width: 1
        border.color: popup.mochaSurface0
        opacity: popup.visible ? 0.98 : 0
        scale: popup.visible ? 1 : 0.96
        clip: true
        focus: popup.visible

        Keys.onEscapePressed: (event) => {
            popup.requestClose();
            event.accepted = true;
        }

        MouseArea {
            anchors.fill: parent
            onClicked: mouse.accepted = true
        }

        Rectangle {
            width: 7
            height: 7
            radius: 4
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 22
            anchors.rightMargin: 26
            color: popup.mochaLavender
            opacity: closeArea.containsMouse ? 0.95 : 0.72

            MouseArea {
                id: closeArea

                anchors.fill: parent
                anchors.margins: -10
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: popup.requestClose()
            }
        }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 26
            anchors.rightMargin: 26
            anchors.topMargin: 22
            anchors.bottomMargin: 22
            spacing: 24

            RowLayout {
                Layout.preferredWidth: 314
                Layout.fillHeight: true
                spacing: 14

                Rectangle {
                    Layout.preferredWidth: 104
                    Layout.preferredHeight: 104
                    Layout.alignment: Qt.AlignVCenter
                    radius: 14
                    color: popup.mochaMantle
                    border.width: 1
                    border.color: popup.mochaSurface0
                    clip: true

                    Image {
                        anchors.fill: parent
                        source: mprisService.artUrl
                        fillMode: Image.PreserveAspectCrop
                        visible: mprisService.hasPlayers && source !== ""
                    }

                    Text {
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        anchors.centerIn: parent
                        visible: !mprisService.hasPlayers || mprisService.artUrl === ""
                        text: "󰎈"
                        color: popup.mochaSurface2
                        font.family: "Iosevka Nerd Font"
                        font.pixelSize: 39
                        font.weight: Font.Bold
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 7

                    Item {
                        Layout.fillHeight: true
                    }

                    Text {
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        Layout.fillWidth: true
                        text: mprisService.hasPlayers ? mprisService.title : "No media"
                        color: popup.mochaText
                        font.family: "Iosevka Nerd Font"
                        font.pixelSize: 19
                        font.weight: Font.Bold
                        maximumLineCount: 2
                        wrapMode: Text.Wrap
                        elide: Text.ElideRight
                    }

                    Text {
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        Layout.fillWidth: true
                        text: mprisService.hasPlayers ? (mprisService.artist || mprisService.album || "Media") : "Nothing playing"
                        color: popup.mochaSubtext0
                        font.family: "Iosevka Nerd Font"
                        font.pixelSize: 13
                        font.weight: Font.Bold
                        maximumLineCount: 1
                        elide: Text.ElideRight
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 3
                        radius: 2
                        color: popup.mochaSurface0
                        visible: mprisService.hasPlayers

                        Rectangle {
                            height: parent.height
                            width: parent.width * popup.progressRatio()
                            radius: 2
                            color: popup.mochaLavender
                        }
                    }

                    Row {
                        spacing: 14
                        visible: mprisService.hasPlayers

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            text: "󰒮"
                            color: prevArea.containsMouse ? popup.mochaLavender : popup.mochaText
                            font.family: "Iosevka Nerd Font"
                            font.pixelSize: 21
                            font.weight: Font.Bold

                            MouseArea {
                                id: prevArea

                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: mprisService.previous()
                            }
                        }

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            text: mprisService.activePlayer && mprisService.activePlayer.isPlaying ? "󰏤" : "󰐊"
                            color: playArea.containsMouse ? popup.mochaLavender : popup.mochaText
                            font.family: "Iosevka Nerd Font"
                            font.pixelSize: 23
                            font.weight: Font.Bold

                            MouseArea {
                                id: playArea

                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: mprisService.togglePlaying()
                            }
                        }

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            text: "󰒭"
                            color: nextArea.containsMouse ? popup.mochaLavender : popup.mochaText
                            font.family: "Iosevka Nerd Font"
                            font.pixelSize: 21
                            font.weight: Font.Bold

                            MouseArea {
                                id: nextArea

                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: mprisService.next()
                            }
                        }
                    }

                    Item {
                        Layout.fillHeight: true
                    }
                }
            }

            Rectangle {
                Layout.preferredWidth: 1
                Layout.fillHeight: true
                color: popup.mochaSurface0
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 10

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 14

                    Text {
                        renderType: Text.NativeRendering
                        font.hintingPreference: Font.PreferFullHinting
                        text: Qt.formatDateTime(Services.TimeService.current, "MMM")
                        color: popup.mochaText
                        font.family: "Iosevka Nerd Font"
                        font.pixelSize: 35
                        font.weight: Font.Bold
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 2

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            Layout.fillWidth: true
                            text: Qt.formatDateTime(Services.TimeService.current, "dddd")
                            color: popup.mochaSubtext0
                            font.family: "Iosevka Nerd Font"
                            font.pixelSize: 13
                            font.weight: Font.Bold
                            horizontalAlignment: Text.AlignRight
                        }

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            Layout.fillWidth: true
                            text: Qt.formatDateTime(Services.TimeService.current, "hh:mm AP")
                            color: popup.mochaText
                            font.family: "Iosevka Nerd Font"
                            font.pixelSize: 19
                            font.weight: Font.Bold
                            horizontalAlignment: Text.AlignRight
                        }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 7

                    Repeater {
                        model: 5

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 54
                            radius: 14
                            color: index === 0 ? popup.mochaLavender : popup.mochaMantle
                            border.width: 1
                            border.color: index === 0 ? popup.mochaText : popup.mochaSurface0

                            Column {
                                anchors.centerIn: parent
                                spacing: 4

                                Text {
                                    renderType: Text.NativeRendering
                                    font.hintingPreference: Font.PreferFullHinting
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: Qt.formatDateTime(popup.offsetDate(index), "ddd")
                                    color: index === 0 ? popup.mochaBase : popup.mochaSubtext0
                                    font.family: "Iosevka Nerd Font"
                                    font.pixelSize: 11
                                    font.weight: Font.Bold
                                }

                                Text {
                                    renderType: Text.NativeRendering
                                    font.hintingPreference: Font.PreferFullHinting
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: Qt.formatDateTime(popup.offsetDate(index), "dd")
                                    color: index === 0 ? popup.mochaBase : popup.mochaText
                                    font.family: "Iosevka Nerd Font"
                                    font.pixelSize: index === 0 ? 22 : 18
                                    font.weight: Font.Bold
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 54
                    radius: 16
                    color: popup.mochaMantle
                    border.width: 1
                    border.color: popup.mochaSurface0

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 14
                        anchors.rightMargin: 14
                        spacing: 10

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            text: "󰃭"
                            color: popup.mochaLavender
                            font.family: "Iosevka Nerd Font"
                            font.pixelSize: 21
                            font.weight: Font.Bold
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            Text {
                                renderType: Text.NativeRendering
                                font.hintingPreference: Font.PreferFullHinting
                                Layout.fillWidth: true
                                text: calendarService.monthYearString
                                color: popup.mochaText
                                font.family: "Iosevka Nerd Font"
                                font.pixelSize: 14
                                font.weight: Font.Bold
                                elide: Text.ElideRight
                            }

                            Text {
                                renderType: Text.NativeRendering
                                font.hintingPreference: Font.PreferFullHinting
                                Layout.fillWidth: true
                                text: "Nothing for today"
                                color: popup.mochaSubtext0
                                font.family: "Iosevka Nerd Font"
                                font.pixelSize: 12
                                font.weight: Font.Bold
                                elide: Text.ElideRight
                            }
                        }
                    }
                }
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: 160
                easing.type: Easing.OutCubic
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 180
                easing.type: Easing.OutCubic
            }
        }
    }
}
