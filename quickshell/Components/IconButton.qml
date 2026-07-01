import QtQuick

Rectangle {
    id: button

    property string icon: ""
    property color buttonColor: "#313244"
    property color iconColor: "#b4befe"
    property bool active: false

    signal clicked()

    width: 54
    height: 54
    radius: 18
    color: active ? buttonColor : "#1e1e2e"

    Text {
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        font.family: "Iosevka Nerd Font"
        font.weight: Font.Bold
        anchors.centerIn: parent
        text: button.icon
        color: active ? button.iconColor : "#cdd6f4"
        font.pixelSize: 23
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: button.clicked()
        onPressed: button.scale = 0.95
        onReleased: button.scale = 1
    }

    Behavior on color {
        ColorAnimation {
            duration: 200
        }

    }

    Behavior on scale {
        NumberAnimation {
            duration: 100
        }

    }

}
