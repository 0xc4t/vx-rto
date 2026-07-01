import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

QtObject {
    property bool launcherVisible: false
    property var applications: DesktopEntries.applications
    property int selectedIndex: 0
    property var selectedApp: null
    property string searchText: ""
    property Process launcher

    function launchSelected() {
        launcher.command = ["sh", "-c", "gtk-launch " + selectedApp.id + " > /dev/null 2>&1"];
        launcher.running = false;
        launcher.running = true;
    }

    function closeLauncher() {
        launcherVisible = false;
        searchText = "";
    }

    launcher: Process {
    }

}
