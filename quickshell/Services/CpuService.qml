import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property real usage: 0
    property int usagePercent: 0
    property var _prevIdle: 0
    property var _prevTotal: 0
    property var cpuProcess
    property var updateTimer

    Component.onCompleted: {
        cpuProcess.running = true;
    }

    cpuProcess: Process {
        running: true
        command: ["cat", "/proc/stat"]

        stdout: SplitParser {
            onRead: (data) => {
                if (data.startsWith("cpu ")) {
                    const parts = data.split(' ').filter((c) => {
                        return c !== '';
                    });
                    let idle = parseInt(parts[4]) + parseInt(parts[5]);
                    let total = 0;
                    for (let i = 1; i < parts.length; i++) {
                        total += parseInt(parts[i]);
                    }
                    let diffIdle = idle - root._prevIdle;
                    let diffTotal = total - root._prevTotal;
                    if (diffTotal > 0 && root._prevTotal > 0) {
                        let calc = (diffTotal - diffIdle) / diffTotal;
                        root.usage = calc;
                        root.usagePercent = Math.round(calc * 100);
                    }
                    root._prevIdle = idle;
                    root._prevTotal = total;
                }
            }
        }

    }

    updateTimer: Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProcess.running = false;
            cpuProcess.running = true;
        }
    }

}
