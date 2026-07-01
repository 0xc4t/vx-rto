import "../Components"
import "../Services"
import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root

    property bool closing: false

    signal requestClose()

    function startClose() {
        closing = true;
    }

    visible: LauncherService.launcherVisible
    WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
    exclusionMode: ExclusionMode.Ignore
    anchors.bottom: true
    width: 450
    height: 350
    color: "transparent"
    onVisibleChanged: {
        if (visible) {
            closing = false;
            LauncherService.selectedIndex = 0;
            LauncherService.searchText = "";
            searchBar.text = "";
            Qt.callLater(function() {
                searchBar.forceActiveFocus();
            });
        }
    }

    margins {
        bottom: (visible && !closing) ? -2 : -349

        Behavior on bottom {
            NumberAnimation {
                id: slideAnim

                duration: 320
                easing.type: Easing.OutQuad
                onRunningChanged: {
                    if (!running && root.closing) {
                        root.requestClose();
                        root.closing = false;
                    }
                }
            }

        }

    }

    FocusScope {
        id: mainFocus

        anchors.fill: parent
        focus: true
        Keys.onUpPressed: entriesList.selectPrevious()
        Keys.onDownPressed: entriesList.selectNext()
        Keys.onReturnPressed: {
            LauncherService.launchSelected();
            root.startClose();
        }
        Keys.onEscapePressed: root.startClose()

        Rectangle {
            id: background

            anchors.left: contentColumn.left
            anchors.right: contentColumn.right
            anchors.top: contentColumn.top
            anchors.bottom: contentColumn.bottom
            anchors.margins: -10
            color: "#181825"
            topLeftRadius: 18
            topRightRadius: 18
            border.width: 2
            border.color: "#313244"
        }

        Column {
            id: contentColumn

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            spacing: 10
            clip: true

            DesktopEntriesComponent {
                id: entriesList

                width: parent.width
                height: Math.min(contentHeight, 270)

                Behavior on height {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutQuad
                    }

                }

            }

            LauncherSearch {
                id: searchBar

                focus: true
            }

        }

    }

}
