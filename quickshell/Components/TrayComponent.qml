import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

Rectangle {
    id: root

    property var panelWindow: null
    property color backgroundColor: "#313244"
    property color iconColor: "#cdd6f4"
    property var activeTrayItem: null
    property var activeMenu: null
    property var menuStack: []
    property int menuX: 0
    property int menuY: 0
    readonly property int itemCount: SystemTray.items.values.length
    readonly property int menuItemHeight: 34
    readonly property color mochaCrust: "#11111b"
    readonly property color mochaMantle: "#181825"
    readonly property color mochaBase: "#1e1e2e"
    readonly property color mochaSurface0: "#313244"
    readonly property color mochaSurface1: "#45475a"
    readonly property color mochaSurface2: "#585b70"
    readonly property color mochaText: "#cdd6f4"
    readonly property color mochaSubtext0: "#a6adc8"
    readonly property color mochaLavender: "#b4befe"

    function cleanLabel(label) {
        return String(label || "").replace(/_/g, "");
    }

    function openMenu(item, anchorItem) {
        if (!item || !item.hasMenu)
            return ;

        activeTrayItem = item;
        activeMenu = item.menu;
        let point = anchorItem.mapToItem(null, 0, anchorItem.height + 5);
        menuX = point.x;
        menuY = point.y;
        menuStack = [];
        menuPopup.visible = true;
        menuPopup.anchor.updateAnchor();
    }

    function closeMenu() {
        menuPopup.visible = false;
        activeTrayItem = null;
        activeMenu = null;
        menuStack = [];
    }

    function openSubmenu(entry) {
        menuStack = menuStack.concat([entry]);
        activeMenu = entry;
    }

    function backMenu() {
        if (menuStack.length === 0)
            return ;

        let stack = menuStack.slice(0, menuStack.length - 1);
        menuStack = stack;
        activeMenu = stack.length > 0 ? stack[stack.length - 1] : activeTrayItem.menu;
    }

    function activateEntry(entry) {
        if (!entry || entry.isSeparator || !entry.enabled)
            return ;

        if (entry.hasChildren) {
            openSubmenu(entry);
            return ;
        }

        entry.triggered();
        closeMenu();
    }

    width: itemCount > 0 ? trayRow.implicitWidth + 16 : 0
    height: 26
    radius: 13
    color: root.backgroundColor
    visible: itemCount > 0

    Row {
        id: trayRow

        anchors.centerIn: parent
        spacing: 6

        Repeater {
            model: SystemTray.items

            Item {
                id: trayItem

                width: 18
                height: 18
                anchors.verticalCenter: parent.verticalCenter

                IconImage {
                    anchors.fill: parent
                    source: modelData.icon
                    mipmap: true
                    visible: source !== ""
                }

                Text {
                    renderType: Text.NativeRendering
                    font.hintingPreference: Font.PreferFullHinting
                    anchors.centerIn: parent
                    text: ""
                    color: root.iconColor
                    font.family: "Iosevka Nerd Font"
                    font.pixelSize: 15
                    font.weight: Font.Bold
                    visible: modelData.icon === ""
                }

                MouseArea {
                    id: trayMouse

                    anchors.fill: parent
                    anchors.margins: -4
                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                    cursorShape: Qt.PointingHandCursor
                    onClicked: (mouse) => {
                        if (mouse.button === Qt.RightButton) {
                            root.openMenu(modelData, trayItem);
                        } else if (mouse.button === Qt.MiddleButton) {
                            modelData.secondaryActivate();
                        } else if (modelData.onlyMenu) {
                            root.openMenu(modelData, trayItem);
                        } else {
                            modelData.activate();
                        }
                    }
                    onWheel: (wheel) => {
                        modelData.scroll(wheel.angleDelta.y, false);
                    }
                }
            }
        }
    }

    QsMenuOpener {
        id: menuOpener

        menu: root.activeMenu
    }

    PopupWindow {
        id: menuPopup

        anchor.window: root.panelWindow
        anchor.rect.x: root.menuX
        anchor.rect.y: root.menuY
        anchor.rect.width: 1
        anchor.rect.height: 1
        anchor.edges: Edges.Top | Edges.Left
        anchor.gravity: Edges.Bottom | Edges.Right
        anchor.adjustment: PopupAdjustment.All
        grabFocus: true
        color: "transparent"
        implicitWidth: 230
        implicitHeight: Math.min(menuContent.implicitHeight + 10, 340)
        onVisibleChanged: {
            if (!visible)
                root.closeMenu();

        }

        Rectangle {
            id: menuFrame

            anchors.fill: parent
            radius: 10
            color: root.mochaBase
            border.width: 1
            border.color: root.mochaSurface0
            clip: true

            Flickable {
                anchors.fill: parent
                anchors.margins: 5
                contentWidth: width
                contentHeight: menuContent.implicitHeight
                boundsBehavior: Flickable.StopAtBounds
                clip: true

                Column {
                    id: menuContent

                    width: parent.width
                    spacing: 2

                    Item {
                        width: parent.width
                        height: root.menuStack.length > 0 ? root.menuItemHeight : 0
                        visible: root.menuStack.length > 0

                        Rectangle {
                            anchors.fill: parent
                            radius: 7
                            color: backArea.containsMouse ? root.mochaSurface0 : "transparent"
                        }

                        Row {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.leftMargin: 8
                            anchors.rightMargin: 8
                            spacing: 8

                            Text {
                                renderType: Text.NativeRendering
                                font.hintingPreference: Font.PreferFullHinting
                                anchors.verticalCenter: parent.verticalCenter
                                text: "󰁍"
                                color: root.mochaLavender
                                font.family: "Iosevka Nerd Font"
                                font.pixelSize: 16
                                font.weight: Font.Bold
                            }

                            Text {
                                renderType: Text.NativeRendering
                                font.hintingPreference: Font.PreferFullHinting
                                anchors.verticalCenter: parent.verticalCenter
                                width: parent.width - 28
                                text: "Back"
                                color: root.mochaText
                                font.family: "Iosevka Nerd Font"
                                font.pixelSize: 16
                                font.weight: Font.Bold
                                elide: Text.ElideRight
                            }
                        }

                        MouseArea {
                            id: backArea

                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.backMenu()
                        }
                    }

                    Repeater {
                        model: menuOpener.children

                        Item {
                            id: menuEntry

                            property bool hovered: entryArea.containsMouse
                            property bool actionable: !modelData.isSeparator && modelData.enabled
                            property string label: root.cleanLabel(modelData.text)

                            width: parent.width
                            height: modelData.isSeparator ? 8 : root.menuItemHeight

                            Rectangle {
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.leftMargin: 6
                                anchors.rightMargin: 6
                                height: 1
                                color: root.mochaSurface0
                                visible: modelData.isSeparator
                            }

                            Rectangle {
                                anchors.fill: parent
                                radius: 7
                                color: menuEntry.hovered && menuEntry.actionable ? root.mochaSurface0 : "transparent"
                                visible: !modelData.isSeparator
                            }

                            Row {
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.leftMargin: 8
                                anchors.rightMargin: 8
                                spacing: 8
                                visible: !modelData.isSeparator

                                Text {
                                    renderType: Text.NativeRendering
                                    font.hintingPreference: Font.PreferFullHinting
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 16
                                    text: modelData.buttonType !== QsMenuButtonType.None ? (modelData.checkState === Qt.Checked ? "󰄲" : "󰄱") : ""
                                    color: menuEntry.actionable ? root.mochaLavender : root.mochaSurface2
                                    font.family: "Iosevka Nerd Font"
                                    font.pixelSize: 16
                                    font.weight: Font.Bold
                                    horizontalAlignment: Text.AlignHCenter
                                }

                                IconImage {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 16
                                    height: 16
                                    source: modelData.icon
                                    mipmap: true
                                    visible: source !== ""
                                }

                                Text {
                                    renderType: Text.NativeRendering
                                    font.hintingPreference: Font.PreferFullHinting
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: parent.width - 54 - (modelData.icon !== "" ? 24 : 0)
                                    text: menuEntry.label
                                    color: menuEntry.actionable ? root.mochaText : root.mochaSurface2
                                    font.family: "Iosevka Nerd Font"
                                    font.pixelSize: 16
                                    font.weight: Font.Bold
                                    elide: Text.ElideRight
                                }

                                Text {
                                    renderType: Text.NativeRendering
                                    font.hintingPreference: Font.PreferFullHinting
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 14
                                    text: modelData.hasChildren ? "󰅂" : ""
                                    color: root.mochaSubtext0
                                    font.family: "Iosevka Nerd Font"
                                    font.pixelSize: 16
                                    font.weight: Font.Bold
                                    horizontalAlignment: Text.AlignRight
                                }
                            }

                            MouseArea {
                                id: entryArea

                                anchors.fill: parent
                                hoverEnabled: true
                                enabled: menuEntry.actionable
                                cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                                onClicked: root.activateEntry(modelData)
                            }
                        }
                    }
                }
            }
        }
    }
}
