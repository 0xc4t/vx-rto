import "../Components"
import "../Services" as Services
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: panel

    property var modelData
    property var bgColor
    property var notificationService
    property bool visible: false

    signal requestClose()

    screen: modelData
    exclusionMode: ExclusionMode.Ignore
    focusable: true
    implicitWidth: 340
    color: "transparent"
    WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
    onVisibleChanged: {
        if (visible) {
            Qt.callLater(function() {
                mainRect.forceActiveFocus();
            });
        }
    }

    Services.WifiService {
        id: wifiService
    }

    Services.BluetoothService {
        id: bluetoothService
    }

    Services.BrightnessService {
        id: brightnessService
    }

    Services.VolumeService {
        id: volumeService
    }

    Services.MicService {
        id: micService
    }

    Services.MprisService {
        id: mprisService
    }

    Services.CalendarService {
        id: calendarService
    }

    anchors {
        right: true
        top: true
        bottom: true
    }

    margins {
        top: 40
        right: visible ? 0 : -335

        Behavior on right {
            NumberAnimation {
                duration: 400
                easing.type: Easing.OutCubic
            }

        }

    }

    Rectangle {
        id: mainRect

        property string currentView: "notifications"
        readonly property int viewIndex: indexForView(currentView)

        function indexForView(view) {
            switch (view) {
            case "wifi":
                return 1;
            case "bluetooth":
                return 2;
            case "brightness":
                return 3;
            case "audio":
                return 4;
            case "mpris":
                return 5;
            default:
                return 0;
            }
        }

        Connections {
            target: mprisService

            function onHasPlayersChanged() {
                if (!mprisService.hasPlayers && mainRect.currentView === "mpris")
                    mainRect.currentView = "notifications";

            }

        }

        anchors.fill: parent
        anchors.margins: 4
        color: panel.bgColor
        radius: 18
        border.width: 2
        border.color: "#313244"
        focus: panel.visible
        Keys.onEscapePressed: (event) => {
            panel.requestClose();
            event.accepted = true;
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 16

            Row {
                id: iconRow

                property int buttonSize: mprisService.hasPlayers ? 44 : 48
                property int buttonRadius: mprisService.hasPlayers ? 15 : 16

                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 20
                spacing: mprisService.hasPlayers ? 7 : 9

                IconButton {
                    width: iconRow.buttonSize
                    height: iconRow.buttonSize
                    radius: iconRow.buttonRadius
                    icon: "󰂚"
                    buttonColor: "#b4befe"
                    active: mainRect.currentView === "notifications"
                    onClicked: mainRect.currentView = "notifications"
                }

                IconButton {
                    width: iconRow.buttonSize
                    height: iconRow.buttonSize
                    radius: iconRow.buttonRadius
                    icon: "󰖩"
                    buttonColor: "#b4befe"
                    active: mainRect.currentView === "wifi"
                    onClicked: mainRect.currentView = "wifi"
                }

                IconButton {
                    width: iconRow.buttonSize
                    height: iconRow.buttonSize
                    radius: iconRow.buttonRadius
                    icon: "󰂯"
                    buttonColor: "#b4befe"
                    active: mainRect.currentView === "bluetooth"
                    onClicked: mainRect.currentView = "bluetooth"
                }

                IconButton {
                    width: iconRow.buttonSize
                    height: iconRow.buttonSize
                    radius: iconRow.buttonRadius
                    icon: "󰃞"
                    buttonColor: "#b4befe"
                    active: mainRect.currentView === "brightness"
                    onClicked: mainRect.currentView = "brightness"
                }

                IconButton {
                    width: iconRow.buttonSize
                    height: iconRow.buttonSize
                    radius: iconRow.buttonRadius
                    icon: "󰕾"
                    buttonColor: "#b4befe"
                    active: mainRect.currentView === "audio"
                    onClicked: mainRect.currentView = "audio"
                }

                IconButton {
                    width: iconRow.buttonSize
                    height: iconRow.buttonSize
                    radius: iconRow.buttonRadius
                    visible: mprisService.hasPlayers
                    icon: mprisService.activePlayer && mprisService.activePlayer.isPlaying ? "󰎈" : "󰝚"
                    buttonColor: "#b4befe"
                    active: mainRect.currentView === "mpris"
                    onClicked: mainRect.currentView = "mpris"
                }
            }

            Item {
                id: middleContainer

                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                NotificationPanelComponent {
                    width: parent.width
                    height: parent.height
                    notificationService: panel.notificationService
                    x: (0 - mainRect.viewIndex) * width

                    Behavior on x {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.OutCubic
                        }

                    }

                }

                WifiComponent {
                    width: parent.width
                    height: parent.height
                    wifiService: wifiService
                    x: (1 - mainRect.viewIndex) * width

                    Behavior on x {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.OutCubic
                        }

                    }

                }

                BluetoothComponent {
                    width: parent.width
                    height: parent.height
                    x: (2 - mainRect.viewIndex) * width

                    Behavior on x {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.OutCubic
                        }

                    }

                }

                Item {
                    width: parent.width
                    height: parent.height
                    x: (3 - mainRect.viewIndex) * width

                    Behavior on x {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.OutCubic
                        }

                    }

                    BrightnessComponent {
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                        service: brightnessService
                    }

                }

                Item {
                    width: parent.width
                    height: parent.height
                    x: (4 - mainRect.viewIndex) * width

                    Behavior on x {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.OutCubic
                        }

                    }

                    AudioComponent {
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                        volumeService: volumeService
                        micService: micService
                    }

                }

                Item {
                    width: parent.width
                    height: parent.height
                    x: (5 - mainRect.viewIndex) * width

                    Behavior on x {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.OutCubic
                        }

                    }

                    MprisComponent {
                        width: parent.width
                        height: parent.height
                        service: mprisService
                    }

                }

            }

            CalendarComponent {
                Layout.fillWidth: true
                Layout.preferredHeight: 300
                service: calendarService
            }

        }

    }

}
