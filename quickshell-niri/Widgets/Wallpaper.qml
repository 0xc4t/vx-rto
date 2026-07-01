import Qt.labs.folderlistmodel 2.15
import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root

    property var modelData
    property var screen: modelData
    property string wallpaperFolder: "../Wallpapers"

    WlrLayershell.namespace: "wallpaper"
    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.exclusiveZone: -1
    WlrLayershell.keyboardFocus: WlrLayershell.None
    color: "transparent"

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    FolderListModel {
        id: wpModel

        folder: Qt.resolvedUrl(root.wallpaperFolder)
        nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp"]
        showDirs: false
        sortField: FolderListModel.Name
    }

    Image {
        anchors.fill: parent
        anchors.topMargin: 40
        fillMode: Image.PreserveAspectCrop
        source: wpModel.count > 0 ? wpModel.get(0, "fileUrl") : ""
    }

}
