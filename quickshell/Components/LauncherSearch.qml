import "../Services"
import QtQuick

FocusScope {
    id: searchScope

    property alias text: textInput.text

    width: parent.width
    height: 50

    Rectangle {
        anchors.fill: parent
        color: "#1e1e2e"
        radius: 8
        border.color: "#313244"
        border.width: 1

        TextInput {
            renderType: TextInput.NativeRendering
            font.hintingPreference: Font.PreferFullHinting
            id: textInput

            font.family: "Iosevka Nerd Font"
            font.weight: Font.Bold
            anchors.fill: parent
            anchors.margins: 15
            color: "white"
            font.pixelSize: 19
            verticalAlignment: TextInput.AlignVCenter
            focus: true
            onTextChanged: {
                LauncherService.searchText = text;
            }

            Text {
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                font.family: "Iosevka Nerd Font"
                font.weight: Font.Bold
                anchors.fill: parent
                text: "Search applications..."
                color: "#666666"
                font.pixelSize: 19
                verticalAlignment: Text.AlignVCenter
                visible: textInput.text.length === 0
            }

        }

    }

}
