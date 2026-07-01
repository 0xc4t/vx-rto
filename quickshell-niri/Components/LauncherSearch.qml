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

        SharpTextInput {
            id: textInput
            font.weight: Font.ExtraBold
            anchors.fill: parent
            anchors.margins: 15
            color: "white"
            font.pixelSize: 18
            verticalAlignment: TextInput.AlignVCenter
            focus: true
            onTextChanged: {
                LauncherService.searchText = text;
            }

            SharpText {
                font.weight: Font.ExtraBold
                anchors.fill: parent
                text: "Search applications..."
                color: "#666666"
                font.pixelSize: 18
                verticalAlignment: Text.AlignVCenter
                visible: textInput.text.length === 0
            }

        }

    }

}
