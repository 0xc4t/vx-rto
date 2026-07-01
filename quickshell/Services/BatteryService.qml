import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property real batteryLevel: 0
    property int batteryPercent: 0
    property string status: "Unknown"
    property bool isCharging: false
    property var capacityProcess
    property var statusProcess
    property var updateTimer

    Component.onCompleted: {
        // Initial read
        capacityProcess.running = true;
        statusProcess.running = true;
    }

    capacityProcess: Process {
        running: true
        command: ["bash", "-c", "cat /sys/class/power_supply/BAT0/capacity 2>/dev/null"]

        stdout: SplitParser {
            onRead: (data) => {
                let value = parseInt(data.trim());
                if (!isNaN(value)) {
                    root.batteryPercent = value;
                    root.batteryLevel = value / 100;
                }
            }
        }

    }

    statusProcess: Process {
        running: true
        command: ["bash", "-c", "cat /sys/class/power_supply/BAT0/status 2>/dev/null"]

        stdout: SplitParser {
            onRead: (data) => {
                root.status = data.trim();
                root.isCharging = (root.status === "Charging");
            }
        }

    }

    updateTimer: Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            capacityProcess.running = false;
            statusProcess.running = false;
            capacityProcess.running = true;
            statusProcess.running = true;
        }
    }

}
