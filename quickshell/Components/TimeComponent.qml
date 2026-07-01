import "../Services"
import QtQuick

Rectangle {
    id: root

    property color backgroundColor: "#313244"
    property color textColor: "#cdd6f4"

    signal clicked()

    width: timeText.implicitWidth + 20
    height: 26
    radius: 13
    color: root.backgroundColor

    Text {
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        id: timeText

        anchors.centerIn: parent
        anchors.verticalCenterOffset: 1
        text: Qt.formatDateTime(TimeService.current, "hh:mm AP • dddd, dd MMM yyyy")
        color: root.textColor
        font.pixelSize: 16
        font.family: "Iosevka Nerd Font"
        font.weight: Font.Bold
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
