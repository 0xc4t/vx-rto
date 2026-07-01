import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property var service
    readonly property var player: service ? service.activePlayer : null
    readonly property bool hasPlayer: service && service.hasPlayers && player
    property int progressTick: 0

    function seconds(value) {
        if (!value || value < 0)
            return 0;

        return value > 100000 ? value / 1000000 : value;
    }

    function progressRatio() {
        root.progressTick;
        if (!root.player || !root.player.lengthSupported)
            return 0;

        let length = seconds(root.player.length);
        if (length <= 0)
            return 0;

        return Math.max(0, Math.min(1, seconds(root.player.position) / length));
    }

    function formatTime(value) {
        let total = Math.floor(seconds(value));
        let minutes = Math.floor(total / 60);
        let secs = total % 60;
        return minutes + ":" + (secs < 10 ? "0" : "") + secs;
    }

    Timer {
        interval: 1000
        running: root.hasPlayer
        repeat: true
        onTriggered: root.progressTick++
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 14

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 156
            Layout.preferredHeight: 156
            radius: 12
            color: "#1e1e2e"
            border.width: 1
            border.color: "#313244"
            clip: true

            Image {
                anchors.fill: parent
                source: root.service ? root.service.artUrl : ""
                fillMode: Image.PreserveAspectCrop
                visible: source !== ""
            }

            Text {
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                anchors.centerIn: parent
                visible: !root.hasPlayer || !root.service || root.service.artUrl === ""
                font.family: "Iosevka Nerd Font"
                font.weight: Font.Bold
                text: "󰎈"
                color: "#585b70"
                font.pixelSize: 49
            }

        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 4

            Text {
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.family: "Iosevka Nerd Font"
                font.weight: Font.Bold
                text: root.hasPlayer && root.service.title ? root.service.title : "No media"
                color: "#cdd6f4"
                font.pixelSize: 19
                elide: Text.ElideRight
            }

            Text {
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                font.family: "Iosevka Nerd Font"
                font.weight: Font.Bold
                text: root.hasPlayer ? (root.service.artist || root.service.album || root.player.identity) : "Play something first"
                color: "#a6adc8"
                font.pixelSize: 14
                elide: Text.ElideRight
            }

        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 8
            visible: root.hasPlayer

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 4
                radius: 2
                color: "#45475a"

                Rectangle {
                    width: parent.width * root.progressRatio()
                    height: parent.height
                    radius: 2
                    color: "#b4befe"
                }

            }

            RowLayout {
                Layout.fillWidth: true

                Text {
                    renderType: Text.NativeRendering
                    font.hintingPreference: Font.PreferFullHinting
                    Layout.fillWidth: true
                    font.family: "Iosevka Nerd Font"
                    font.weight: Font.Bold
                    text: root.player ? root.formatTime(root.player.position) : "0:00"
                    color: "#6c7086"
                    font.pixelSize: 13
                }

                Text {
                    renderType: Text.NativeRendering
                    font.hintingPreference: Font.PreferFullHinting
                    font.family: "Iosevka Nerd Font"
                    font.weight: Font.Bold
                    text: root.player && root.player.lengthSupported ? root.formatTime(root.player.length) : "--:--"
                    color: "#6c7086"
                    font.pixelSize: 13
                }

            }

        }

        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 12
            visible: root.hasPlayer

            Rectangle {
                width: 42
                height: 42
                radius: 14
                enabled: root.player && root.player.canGoPrevious
                color: previousArea.containsMouse && enabled ? "#45475a" : "#313244"

                Text {
                    renderType: Text.NativeRendering
                    font.hintingPreference: Font.PreferFullHinting
                    anchors.centerIn: parent
                    font.family: "Iosevka Nerd Font"
                    font.weight: Font.Bold
                    text: "󰒮"
                    color: parent.enabled ? "#cdd6f4" : "#585b70"
                    font.pixelSize: 21
                }

                MouseArea {
                    id: previousArea

                    anchors.fill: parent
                    hoverEnabled: true
                    enabled: parent.enabled
                    cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: root.service.previous()
                }

            }

            Rectangle {
                width: 50
                height: 50
                radius: 18
                enabled: root.player && root.player.canTogglePlaying
                color: "#b4befe"

                Text {
                    renderType: Text.NativeRendering
                    font.hintingPreference: Font.PreferFullHinting
                    anchors.centerIn: parent
                    font.family: "Iosevka Nerd Font"
                    font.weight: Font.Bold
                    text: root.player && root.player.isPlaying ? "󰏤" : "󰐊"
                    color: "#1e1e2e"
                    font.pixelSize: 25
                }

                MouseArea {
                    anchors.fill: parent
                    enabled: parent.enabled
                    cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: root.service.togglePlaying()
                }

            }

            Rectangle {
                width: 42
                height: 42
                radius: 14
                enabled: root.player && root.player.canGoNext
                color: nextArea.containsMouse && enabled ? "#45475a" : "#313244"

                Text {
                    renderType: Text.NativeRendering
                    font.hintingPreference: Font.PreferFullHinting
                    anchors.centerIn: parent
                    font.family: "Iosevka Nerd Font"
                    font.weight: Font.Bold
                    text: "󰒭"
                    color: parent.enabled ? "#cdd6f4" : "#585b70"
                    font.pixelSize: 21
                }

                MouseArea {
                    id: nextArea

                    anchors.fill: parent
                    hoverEnabled: true
                    enabled: parent.enabled
                    cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                    onClicked: root.service.next()
                }

            }

        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

    }

}
