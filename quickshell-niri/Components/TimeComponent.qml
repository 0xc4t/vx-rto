import "../Services"
import QtQuick

Rectangle {
    id: root

    property color textColor: "#cdd6f4"

    width: dateText.implicitWidth + 20
    height: 26
    radius: 13
    color: "#1e1e2e"

    SharpText {
        id: dateText

        anchors.centerIn: parent
        text: Qt.formatDateTime(TimeService.current, "hh:mm AP • dddd, dd MMM yyyy")
        color: root.textColor
        font.pixelSize: 17
        font.weight: Font.ExtraBold
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

}
