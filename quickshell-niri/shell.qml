pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io
import "Widgets" as WG
import "Services" as Services
import Quickshell.Wayland

ShellRoot {
    id: root
    property color systemColor: "#181825"
    property color systemAccent: "#b4befe"
    property bool launcherVisible: false
    property bool sidebarVisible: false

    Services.NotificationService {
        id: notificationService
    }

    IpcHandler {
        target: "launcher"
        function toggle() {
            root.launcherVisible = !root.launcherVisible;
        }
    }

    WG.Wallpaper {}
    WG.Sidebar {
        bgColor: root.systemColor
        notificationService: notificationService
        visible: root.sidebarVisible
        onRequestClose: root.sidebarVisible = false
    }
    WG.Bar {
        bgColor: root.systemColor
        sidebarVisible: root.sidebarVisible
        onToggleSidebar: root.sidebarVisible = !root.sidebarVisible
    }
    WG.Overlay {
        bgColor: root.systemColor
    }
    WG.NotificationPopups {
        notificationService: notificationService
    }
    WG.LauncherV2 {
        visible: root.launcherVisible
        onRequestClose: root.launcherVisible = false
    }
}
