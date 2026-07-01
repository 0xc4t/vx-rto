import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    property var wifiService
    property string expandedSSID: ""

    color: "transparent"

    Flickable {
        anchors.fill: parent
        contentWidth: width
        contentHeight: content.height
        clip: true

        Column {
            id: content

            width: parent.width
            spacing: 12
            padding: 12

            Rectangle {
                width: parent.width - 24
                height: 60
                radius: 12
                color: "#1e1e2e"
                border.width: 1
                border.color: wifiService.isEthernetConnected ? "#a6e3a1" : "#313244"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 12

                    Rectangle {
                        Layout.preferredWidth: 36
                        Layout.preferredHeight: 36
                        radius: 18
                        color: wifiService.isEthernetConnected ? "#a6e3a1" : "#313244"

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            font.family: "Iosevka Nerd Font"
                            font.weight: Font.Bold
                            anchors.centerIn: parent
                            text: wifiService.isEthernetConnected ? "󰈀" : "󰖩"
                            font.pixelSize: 23
                            color: wifiService.isEthernetConnected ? "#1e1e2e" : "#cdd6f4"
                        }

                    }

                    Column {
                        Layout.fillWidth: true
                        spacing: 2

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            text: wifiService.isEthernetConnected ? "Network" : (wifiService.isEnabled ? "WiFi" : "WiFi Off")
                            font.pixelSize: 17
                            font.family: "Iosevka Nerd Font"
                            font.weight: Font.Bold
                            color: "#cdd6f4"
                        }

                        Text {
                            renderType: Text.NativeRendering
                            font.hintingPreference: Font.PreferFullHinting
                            text: wifiService.isEthernetConnected ? "Connected" : (wifiService.connectedSSID || "Not connected")
                            font.pixelSize: 15
                            font.family: "Iosevka Nerd Font"
                            font.weight: Font.Bold
                            color: wifiService.isEthernetConnected ? "#a6e3a1" : (wifiService.connectedSSID ? "#b4befe" : "#a6adc8")
                            visible: wifiService.isEthernetConnected || wifiService.isEnabled
                        }

                    }

                    Rectangle {
                        visible: !wifiService.isEthernetConnected
                        Layout.preferredWidth: 40
                        Layout.preferredHeight: 24
                        radius: 12
                        color: "#313244"

                        Rectangle {
                            width: 20
                            height: 20
                            radius: 10
                            color: "#ffffff"
                            anchors.verticalCenter: parent.verticalCenter
                            x: wifiService.isEnabled ? parent.width - width - 2 : 2

                            Behavior on x {
                                NumberAnimation {
                                    duration: 200
                                }

                            }

                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: wifiService.toggleRadio()
                        }

                    }

                }

            }

            Column {
                width: parent.width - 24
                spacing: 8
                visible: wifiService.isEnabled && !wifiService.isEthernetConnected

                Text {
                    renderType: Text.NativeRendering
                    font.hintingPreference: Font.PreferFullHinting
                    text: "Available Networks"
                    font.pixelSize: 16
                    font.family: "Iosevka Nerd Font"
                    font.weight: Font.Bold
                    color: "#cdd6f4"
                }

                Repeater {
                    model: wifiService.networks

                    Rectangle {
                        id: netCard

                        property bool isConnected: model.ssid === wifiService.connectedSSID
                        property bool isConnecting: model.ssid === wifiService.connectingSSID
                        property bool hasError: wifiService.connectionError !== "" && wifiService.connectionError !== "failed" && root.expandedSSID === model.ssid
                        property bool isExpanded: root.expandedSSID === model.ssid && !isConnected
                        property string passwordInput: ""

                        width: parent.width
                        height: isExpanded ? (hasError ? 140 : 110) : 50
                        radius: 10
                        color: "#1e1e2e"
                        clip: true

                        // Auto re-open input form on error
                        Connections {
                            function onConnectionErrorChanged() {
                                if (wifiService.connectionError !== "" && wifiService.connectingSSID === "" && model.ssid !== wifiService.connectedSSID)
                                    root.expandedSSID = model.ssid;

                            }

                            target: wifiService
                        }

                        MouseArea {
                            width: parent.width
                            height: 50
                            cursorShape: Qt.PointingHandCursor
                            enabled: !netCard.isConnecting
                            onClicked: {
                                if (netCard.isConnected) {
                                    wifiService.disconnect();
                                } else {
                                    if (model.isKnown) {
                                        console.log("Connecting to known network: " + model.ssid);
                                        wifiService.connect(model.ssid, "");
                                        root.expandedSSID = "";
                                    } else {
                                        if (root.expandedSSID === model.ssid) {
                                            root.expandedSSID = "";
                                            wifiService.clearError();
                                        } else {
                                            root.expandedSSID = model.ssid;
                                            netCard.passwordInput = "";
                                            wifiService.clearError();
                                        }
                                    }
                                }
                            }
                        }

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 8

                            RowLayout {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 30
                                spacing: 10

                                Text {
                                    renderType: Text.NativeRendering
                                    font.hintingPreference: Font.PreferFullHinting
                                    font.family: "Iosevka Nerd Font"
                                    font.weight: Font.Bold
                                    text: model.signal > 75 ? "󰤨" : model.signal > 50 ? "󰤥" : model.signal > 25 ? "󰤢" : "󰤟"
                                    font.pixelSize: 21
                                    color: "#b4befe"
                                }

                                Column {
                                    Layout.fillWidth: true

                                    Text {
                                        renderType: Text.NativeRendering
                                        font.hintingPreference: Font.PreferFullHinting
                                        text: model.ssid
                                        font.pixelSize: 16
                                        font.family: "Iosevka Nerd Font"
                                        font.weight: Font.Bold
                                        color: netCard.isConnected ? "#b4befe" : "#cdd6f4"
                                    }

                                    Text {
                                        renderType: Text.NativeRendering
                                        font.hintingPreference: Font.PreferFullHinting
                                        text: model.secured ? "󰌾  Secured" : "󰿆  Open"
                                        font.pixelSize: 13
                                        font.family: "Iosevka Nerd Font"
                                        font.weight: Font.Bold
                                        color: "#a6adc8"
                                    }

                                }

                                // Connected status
                                Text {
                                    renderType: Text.NativeRendering
                                    font.hintingPreference: Font.PreferFullHinting
                                    visible: netCard.isConnected
                                    text: "Connected"
                                    font.pixelSize: 14
                                    font.family: "Iosevka Nerd Font"
                                    font.weight: Font.Bold
                                    color: "#a6e3a1"
                                }

                                // Connecting status
                                RowLayout {
                                    visible: netCard.isConnecting
                                    spacing: 6

                                    Text {
                                        renderType: Text.NativeRendering
                                        font.hintingPreference: Font.PreferFullHinting
                                        font.family: "Iosevka Nerd Font"
                                        font.weight: Font.Bold
                                        text: "󰔟"
                                        font.pixelSize: 17
                                        color: "#b4befe"

                                        RotationAnimation on rotation {
                                            running: netCard.isConnecting
                                            from: 0
                                            to: 360
                                            duration: 1000
                                            loops: Animation.Infinite
                                        }

                                    }

                                    Text {
                                        renderType: Text.NativeRendering
                                        font.hintingPreference: Font.PreferFullHinting
                                        text: "Connecting"
                                        font.pixelSize: 14
                                        font.family: "Iosevka Nerd Font"
                                        font.weight: Font.Bold
                                        color: "#b4befe"
                                    }

                                }

                            }

                            // Error message
                            Text {
                                renderType: Text.NativeRendering
                                font.hintingPreference: Font.PreferFullHinting
                                visible: netCard.hasError
                                Layout.fillWidth: true
                                text: "󰀪  Invalid credentials, please try again"
                                font.pixelSize: 13
                                font.family: "Iosevka Nerd Font"
                                font.weight: Font.Bold
                                color: "#f38ba8"
                                wrapMode: Text.WordWrap
                            }

                            // Password input row
                            RowLayout {
                                visible: netCard.isExpanded && !netCard.isConnecting
                                Layout.fillWidth: true
                                Layout.preferredHeight: 36
                                spacing: 8
                                opacity: (netCard.isExpanded && !netCard.isConnecting) ? 1 : 0

                                Rectangle {
                                    Layout.fillWidth: true
                                    implicitHeight: 28
                                    color: "#313244"
                                    radius: 6
                                    border.width: netCard.hasError ? 1 : 0
                                    border.color: netCard.hasError ? "#f38ba8" : "transparent"

                                    TextInput {
                                        renderType: TextInput.NativeRendering
                                        font.hintingPreference: Font.PreferFullHinting
                                        id: passInput

                                        anchors.fill: parent
                                        anchors.leftMargin: 10
                                        anchors.rightMargin: 30
                                        verticalAlignment: Text.AlignVCenter
                                        font.pixelSize: 15
                                        font.family: "Iosevka Nerd Font"
                                        font.weight: Font.Bold
                                        color: "#cdd6f4"
                                        echoMode: showPassBtn.show ? TextInput.Normal : TextInput.Password
                                        passwordCharacter: "•"
                                        text: netCard.passwordInput
                                        onTextChanged: {
                                            netCard.passwordInput = text;
                                            if (wifiService.connectionError !== "")
                                                wifiService.clearError();

                                        }
                                        clip: true
                                        onVisibleChanged: {
                                            if (visible)
                                                forceActiveFocus();

                                        }
                                        onAccepted: {
                                            wifiService.connect(model.ssid, netCard.passwordInput);
                                            root.expandedSSID = "";
                                        }
                                    }

                                    Text {
                                        renderType: Text.NativeRendering
                                        font.hintingPreference: Font.PreferFullHinting
                                        id: showPassBtn

                                        property bool show: false

                                        font.family: "Iosevka Nerd Font"
                                        font.weight: Font.Bold
                                        anchors.right: parent.right
                                        anchors.rightMargin: 8
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: show ? "󰈈" : "󰈉"
                                        font.pixelSize: 17
                                        color: "#a6adc8"

                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: showPassBtn.show = !showPassBtn.show
                                        }

                                    }

                                }

                                Rectangle {
                                    implicitWidth: 28
                                    implicitHeight: 28
                                    radius: 6
                                    color: "#313244"
                                    border.width: 1
                                    border.color: "#f38ba8"

                                    Text {
                                        renderType: Text.NativeRendering
                                        font.hintingPreference: Font.PreferFullHinting
                                        font.family: "Iosevka Nerd Font"
                                        font.weight: Font.Bold
                                        anchors.centerIn: parent
                                        text: "󰅖"
                                        font.pixelSize: 17
                                        color: "#f38ba8"
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            root.expandedSSID = "";
                                            wifiService.clearError();
                                        }
                                    }

                                }

                                Rectangle {
                                    implicitWidth: 28
                                    implicitHeight: 28
                                    radius: 6
                                    color: "#a6e3a1"

                                    Text {
                                        renderType: Text.NativeRendering
                                        font.hintingPreference: Font.PreferFullHinting
                                        font.family: "Iosevka Nerd Font"
                                        anchors.centerIn: parent
                                        text: "󰄬"
                                        font.pixelSize: 19
                                        color: "#1e1e2e"
                                        font.weight: Font.Bold
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            wifiService.connect(model.ssid, netCard.passwordInput);
                                            root.expandedSSID = "";
                                        }
                                    }

                                }

                                Behavior on opacity {
                                    NumberAnimation {
                                        duration: 200
                                    }

                                }

                            }

                        }

                        Behavior on height {
                            NumberAnimation {
                                duration: 200
                                easing.type: Easing.OutCubic
                            }

                        }

                    }

                }

            }

            Text {
                renderType: Text.NativeRendering
                font.hintingPreference: Font.PreferFullHinting
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: "Scanning..."
                font.pixelSize: 15
                font.family: "Iosevka Nerd Font"
                font.weight: Font.Bold
                color: "#6c7086"
                visible: wifiService.networks.count === 0 && wifiService.isEnabled
            }

        }

    }

}
