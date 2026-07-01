import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: btService

    property bool isPowered: false
    property bool isScanning: false
    property ListModel pairedDevices
    property ListModel newDevices
    property var _tempPaired: []
    property var _tempConnected: []
    property var _tempAll: []

    function normalizeMac(mac) {
        return String(mac || "").toUpperCase();
    }

    function hasDevice(targetArray, mac) {
        let normalized = normalizeMac(mac);
        for (let i = 0; i < targetArray.length; i++) {
            if (normalizeMac(targetArray[i].mac) === normalized)
                return true;

        }
        return false;
    }

    function isPlaceholderName(name, mac) {
        let cleanName = String(name || "").trim().toUpperCase();
        let dashedMac = normalizeMac(mac).replace(/:/g, "-");
        return cleanName === "" || cleanName === normalizeMac(mac) || cleanName === dashedMac || /^[0-9A-F]{2}(-[0-9A-F]{2}){5}$/.test(cleanName);
    }

    function parseDeviceLine(line, targetArray, context) {
        if (!line || line.trim() === "")
            return ;

        var clean = line.replace(/\x1B\[[0-9;]*[a-zA-Z]/g, "").trim();
        var parts = clean.split(" ");
        if (parts.length >= 2 && parts[0] === "Device") {
            var mac = parts[1];
            if (hasDevice(targetArray, mac))
                return;

            var name = parts.slice(2).join(" ") || "Unknown Device";
            targetArray.push({
                "mac": mac,
                "name": name,
                "connected": false
            });
        }
    }

    function updateModels() {
        pairedDevices.clear();
        var connectedMacs = _tempConnected.map((d) => {
            return normalizeMac(d.mac);
        });
        for (var i = 0; i < _tempPaired.length; i++) {
            var paired = _tempPaired[i];
            paired.connected = connectedMacs.includes(normalizeMac(paired.mac));
            pairedDevices.append(paired);
        }
        newDevices.clear();
        var pairedMacs = _tempPaired.map((d) => {
            return normalizeMac(d.mac);
        });
        for (var j = 0; j < _tempAll.length; j++) {
            var dev = _tempAll[j];
            if (!pairedMacs.includes(normalizeMac(dev.mac)) && !isPlaceholderName(dev.name, dev.mac))
                newDevices.append(dev);

        }
    }

    function refresh() {
        statusProc.running = true;
        if (isPowered) {
            fetchPairedProc.running = true;
        } else {
            pairedDevices.clear();
            newDevices.clear();
        }
    }

    function schedule(callback, interval) {
        delayTimer.stop();
        delayTimer.callback = callback;
        delayTimer.interval = interval;
        delayTimer.start();
    }

    function toggleScan() {
        if (isScanning) {
            btService.isScanning = false;
            actionProc.command = ["bluetoothctl", "scan", "off"];
            actionProc.running = true;
        } else {
            btService.isScanning = true;
            actionProc.command = ["bluetoothctl", "scan", "on"];
            actionProc.running = true;
        }
        schedule(refresh, 1000);
    }

    function togglePower() {
        if (isPowered) {
            btService.isScanning = false;
            actionProc.command = ["bash", "-lc", "bluetoothctl scan off >/dev/null 2>&1; bluetoothctl power off"];
        } else {
            actionProc.command = ["bluetoothctl", "power", "on"];
        }
        actionProc.running = true;

        schedule(refresh, 2000);
    }

    function connectDevice(mac) {
        actionProc.command = ["bluetoothctl", "connect", mac];
        actionProc.running = true;
        schedule(refresh, 2500);
    }

    function disconnectDevice(mac) {
        actionProc.command = ["bluetoothctl", "disconnect", mac];
        actionProc.running = true;
        schedule(refresh, 1500);
    }

    function pairAndConnect(mac) {
        if (_tempPaired.some((d) => {
            return normalizeMac(d.mac) === normalizeMac(mac);
        })) {
            connectDevice(mac);
            return;
        }

        actionProc.command = ["bash", "-lc", "bluetoothctl pair " + mac + " && bluetoothctl trust " + mac + " && bluetoothctl connect " + mac];
        actionProc.running = true;
        schedule(refresh, 3500);
    }

    function forgetDevice(mac) {
        actionProc.command = ["bluetoothctl", "remove", mac];
        actionProc.running = true;
        schedule(refresh, 2000);
    }

    Component.onCompleted: refresh()

    Process {
        id: statusProc

        command: ["bluetoothctl", "show"]

        stdout: SplitParser {
            onRead: (data) => {
                if (data.includes("Powered: yes"))
                    btService.isPowered = true;
                else if (data.includes("Powered: no"))
                    btService.isPowered = false;
                if (data.includes("Discovering: yes"))
                    btService.isScanning = true;
                else if (data.includes("Discovering: no"))
                    btService.isScanning = false;
            }
        }

    }

    Process {
        id: fetchPairedProc

        command: ["bluetoothctl", "devices", "Paired"]
        onStarted: btService._tempPaired = []
        onExited: fetchConnectedProc.running = true

        stdout: SplitParser {
            onRead: (data) => {
                return parseDeviceLine(data, btService._tempPaired, "Paired");
            }
        }

    }

    Process {
        id: fetchConnectedProc

        command: ["bluetoothctl", "devices", "Connected"]
        onStarted: btService._tempConnected = []
        onExited: fetchAllProc.running = true

        stdout: SplitParser {
            onRead: (data) => {
                return parseDeviceLine(data, btService._tempConnected, "Connected");
            }
        }

    }

    Process {
        id: fetchAllProc

        command: ["bluetoothctl", "devices"]
        onStarted: btService._tempAll = []
        onExited: updateModels()

        stdout: SplitParser {
            onRead: (data) => {
                return parseDeviceLine(data, btService._tempAll, "All");
            }
        }

    }

    Process {
        id: actionProc

        stdout: SplitParser {
            onRead: (data) => {
                return console.log("[BT]: " + data);
            }
        }

    }

    Timer {
        id: delayTimer

        property var callback: function() {
        }

        interval: 3500
        onTriggered: callback()
    }

    Timer {
        interval: 20000
        running: true
        repeat: true
        onTriggered: refresh()
    }

    Timer {
        interval: 3000
        running: btService.isPowered && btService.isScanning
        repeat: true
        onTriggered: refresh()
    }

    pairedDevices: ListModel {
    }

    newDevices: ListModel {
    }

}
