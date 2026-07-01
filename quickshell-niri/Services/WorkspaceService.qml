import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root

    property int activeIndex: 0
    property string activeWindowTitle: "Desktop"
    property alias model: workspaceModel
    property int minimumWorkspaces: 5
    property bool isSway: (Quickshell.env("XDG_CURRENT_DESKTOP") || "").toLowerCase().includes("sway")

    function focus(idx) {
        if (idx < 0 || idx >= workspaceModel.count)
            return;

        let workspace = workspaceModel.get(idx);
        if (root.isSway) {
            let wsId = workspace.workspaceId;
            focusProcess.command = ["swaymsg", "workspace", "number", wsId.toString()];
        } else {
            focusProcess.command = ["niri", "msg", "action", "focus-workspace", workspace.idx.toString()];
        }
        focusProcess.running = true;
    }

    function syncWorkspaceModel(items) {
        let byIndex = {};
        let maxIndex = root.minimumWorkspaces;

        for (let i = 0; i < items.length; i++) {
            let item = items[i];
            let idx = Math.max(1, Math.round(Number(item.idx) || 1));
            item.idx = idx;
            byIndex[idx] = item;
            maxIndex = Math.max(maxIndex, idx);
            if (item.active)
                root.activeIndex = idx - 1;

        }

        for (let idx = 1; idx <= maxIndex; idx++) {
            let itemData = byIndex[idx] || {
                "workspaceId": idx,
                "idx": idx,
                "active": false
            };
            let modelIndex = idx - 1;
            if (modelIndex < workspaceModel.count) {
                let current = workspaceModel.get(modelIndex);
                if (current.active !== itemData.active || current.workspaceId !== itemData.workspaceId || current.idx !== itemData.idx)
                    workspaceModel.set(modelIndex, itemData);

            } else {
                workspaceModel.append(itemData);
            }
        }
        while (workspaceModel.count > maxIndex) workspaceModel.remove(workspaceModel.count - 1)
    }

    function findFocusedNode(node) {
        if (node.focused)
            return node;

        if (node.nodes) {
            for (let i = 0; i < node.nodes.length; i++) {
                let found = findFocusedNode(node.nodes[i]);
                if (found)
                    return found;

            }
        }
        if (node.floating_nodes) {
            for (let i = 0; i < node.floating_nodes.length; i++) {
                let found = findFocusedNode(node.floating_nodes[i]);
                if (found)
                    return found;

            }
        }
        return null;
    }

    ListModel {
        id: workspaceModel
    }

    Component.onCompleted: syncWorkspaceModel([])

    Process {
        id: focusProcess

        running: false

        stdout: SplitParser {
            onRead: (data) => {
            }
        }

    }

    Process {
        id: swayWsProcess

        property string buffer: ""

        running: false
        command: ["swaymsg", "-t", "get_workspaces", "-r"]
        onExited: (code, status) => {
            if (code !== 0 || swayWsProcess.buffer.trim() === "") {
                swayWsProcess.buffer = "";
                return ;
            }
            try {
                let ws = JSON.parse(swayWsProcess.buffer);
                ws.sort((a, b) => {
                    return a.num - b.num;
                });
                let items = [];
                for (let i = 0; i < ws.length; i++) {
                    let w = ws[i];
                    items.push({
                        "workspaceId": w.num,
                        "idx": w.num,
                        "active": w.focused
                    });
                }
                root.syncWorkspaceModel(items);
            } catch (e) {
                console.error("Sway Ws Parse Error: " + e.message);
            }
            swayWsProcess.buffer = "";
        }

        stdout: SplitParser {
            onRead: (data) => {
                return swayWsProcess.buffer += data;
            }
        }

    }

    Process {
        id: swayTreeProcess

        property string buffer: ""

        running: false
        command: ["swaymsg", "-t", "get_tree", "-r"]
        onExited: (code, status) => {
            if (code !== 0 || swayTreeProcess.buffer.trim() === "") {
                swayTreeProcess.buffer = "";
                return ;
            }
            try {
                let tree = JSON.parse(swayTreeProcess.buffer);
                let focusedNode = findFocusedNode(tree);
                if (focusedNode && focusedNode.name) {
                    if (root.activeWindowTitle !== focusedNode.name)
                        root.activeWindowTitle = focusedNode.name;

                } else {
                    if (root.activeWindowTitle !== "Desktop")
                        root.activeWindowTitle = "Desktop";

                }
            } catch (e) {
                console.error("Sway Tree Parse Error: " + e.message);
            }
            swayTreeProcess.buffer = "";
        }

        stdout: SplitParser {
            onRead: (data) => {
                return swayTreeProcess.buffer += data;
            }
        }

    }

    Process {
        id: niriProcess

        property string buffer: ""

        running: false
        command: ["niri", "msg", "--json", "workspaces"]
        onExited: (code, status) => {
            if (code !== 0 || niriProcess.buffer.trim() === "") {
                niriProcess.buffer = "";
                return ;
            }
            try {
                let ws = JSON.parse(niriProcess.buffer);
                ws.sort((a, b) => {
                    return a.idx - b.idx;
                });
                let items = [];
                for (let i = 0; i < ws.length; i++) {
                    let w = ws[i];
                    items.push({
                        "workspaceId": w.id,
                        "idx": w.idx,
                        "active": w.is_focused
                    });
                }
                root.syncWorkspaceModel(items);
            } catch (e) {
            }
            niriProcess.buffer = "";
        }

        stdout: SplitParser {
            onRead: (data) => {
                return niriProcess.buffer += data;
            }
        }

    }

    Process {
        id: niriWindowProcess

        property string buffer: ""

        running: false
        command: ["niri", "msg", "--json", "windows"]
        onExited: (code, status) => {
            if (code !== 0 || niriWindowProcess.buffer.trim() === "") {
                niriWindowProcess.buffer = "";
                return ;
            }
            try {
                let windows = JSON.parse(niriWindowProcess.buffer);
                let foundFocused = false;
                for (let i = 0; i < windows.length; i++) {
                    if (windows[i].is_focused) {
                        let newTitle = windows[i].title || "Unknown";
                        if (root.activeWindowTitle !== newTitle)
                            root.activeWindowTitle = newTitle;

                        foundFocused = true;
                        break;
                    }
                }
                if (!foundFocused && root.activeWindowTitle !== "Desktop")
                    root.activeWindowTitle = "Desktop";

            } catch (e) {
            }
            niriWindowProcess.buffer = "";
        }

        stdout: SplitParser {
            onRead: (data) => {
                return niriWindowProcess.buffer += data;
            }
        }

    }

    Timer {
        interval: 250
        running: true
        repeat: true
        onTriggered: {
            if (root.isSway) {
                if (!swayWsProcess.running)
                    swayWsProcess.running = true;

                if (!swayTreeProcess.running)
                    swayTreeProcess.running = true;

            } else {
                if (!niriProcess.running)
                    niriProcess.running = true;

                if (!niriWindowProcess.running)
                    niriWindowProcess.running = true;

            }
        }
    }

}
