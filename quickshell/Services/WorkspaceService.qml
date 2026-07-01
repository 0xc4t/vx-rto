import QtQuick
import Quickshell.Hyprland

Item {
    id: root

    property int activeIndex: 0
    readonly property string activeWindowTitle: Hyprland.activeToplevel && Hyprland.activeToplevel.title ? Hyprland.activeToplevel.title : "Desktop"
    property alias model: workspaceModel
    property int minimumWorkspaces: 10
    property bool syncQueued: false

    function isNormalWorkspace(workspace) {
        if (!workspace)
            return false;

        let name = String(workspace.name || "");
        return workspace.id > 0 && !name.startsWith("special:");
    }

    function focusedNormalWorkspace() {
        if (root.isNormalWorkspace(Hyprland.focusedWorkspace))
            return Hyprland.focusedWorkspace;

        if (Hyprland.focusedMonitor && root.isNormalWorkspace(Hyprland.focusedMonitor.activeWorkspace))
            return Hyprland.focusedMonitor.activeWorkspace;

        return null;
    }

    function isEmptyWorkspace(workspace, active) {
        return !active && (!workspace.toplevels || workspace.toplevels.values.length === 0);
    }

    function hasWorkspaceId(items, workspaceId) {
        for (let i = 0; i < items.length; i++) {
            if (items[i].workspaceId === workspaceId)
                return true;

        }
        return false;
    }

    function scheduleSync() {
        if (root.syncQueued)
            return;

        root.syncQueued = true;
        Qt.callLater(() => {
            root.syncQueued = false;
            root.syncFromHyprland();
        });
    }

    function focus(idx) {
        if (idx < 0 || idx >= workspaceModel.count)
            return;

        let workspace = workspaceModel.get(idx);
        Hyprland.dispatch("workspace " + workspace.workspaceId);
    }

    function syncFromHyprland() {
        let focusedWorkspace = root.focusedNormalWorkspace();
        let focusedId = focusedWorkspace ? focusedWorkspace.id : -1;
        let items = [];
        let workspaces = Hyprland.workspaces.values;

        for (let i = 0; i < workspaces.length; i++) {
            let workspace = workspaces[i];
            if (!root.isNormalWorkspace(workspace))
                continue;

            let active = workspace.id === focusedId;
            items.push({
                "workspaceId": workspace.id,
                "idx": workspace.id,
                "name": workspace.name || workspace.id.toString(),
                "active": active,
                "empty": root.isEmptyWorkspace(workspace, active)
            });
        }

        if (focusedWorkspace && !root.hasWorkspaceId(items, focusedWorkspace.id)) {
            items.push({
                "workspaceId": focusedWorkspace.id,
                "idx": focusedWorkspace.id,
                "name": focusedWorkspace.name || focusedWorkspace.id.toString(),
                "active": true,
                "empty": false
            });
        }

        root.syncWorkspaceModel(items);
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
                "name": idx.toString(),
                "active": false,
                "empty": true
            };
            let modelIndex = idx - 1;
            if (modelIndex < workspaceModel.count) {
                let current = workspaceModel.get(modelIndex);
                if (current.active !== itemData.active || current.empty !== itemData.empty || current.workspaceId !== itemData.workspaceId || current.idx !== itemData.idx || current.name !== itemData.name)
                    workspaceModel.set(modelIndex, itemData);

            } else {
                workspaceModel.append(itemData);
            }
        }
        while (workspaceModel.count > maxIndex) workspaceModel.remove(workspaceModel.count - 1);
    }

    ListModel {
        id: workspaceModel
    }

    Connections {
        target: Hyprland

        function onFocusedMonitorChanged() {
            root.scheduleSync();
        }

        function onFocusedWorkspaceChanged() {
            root.scheduleSync();
        }

        function onRawEvent(event) {
            switch (event.name) {
            case "workspace":
            case "focusedmon":
            case "createworkspace":
            case "destroyworkspace":
            case "moveworkspace":
            case "renameworkspace":
                Hyprland.refreshWorkspaces();
                root.scheduleSync();
                break;
            case "activewindow":
            case "activewindowv2":
            case "openwindow":
            case "closewindow":
            case "movewindow":
            case "windowtitle":
            case "windowtitlev2":
                Hyprland.refreshToplevels();
                root.scheduleSync();
                break;
            }
        }
    }

    Connections {
        target: Hyprland.workspaces

        function onValuesChanged() {
            root.scheduleSync();
        }

        function onObjectInsertedPost(object, index) {
            root.scheduleSync();
        }

        function onObjectRemovedPost(object, index) {
            root.scheduleSync();
        }
    }

    Connections {
        target: Hyprland.toplevels

        function onValuesChanged() {
            root.scheduleSync();
        }

        function onObjectInsertedPost(object, index) {
            root.scheduleSync();
        }

        function onObjectRemovedPost(object, index) {
            root.scheduleSync();
        }
    }

    Component.onCompleted: {
        root.syncWorkspaceModel([]);
        Hyprland.refreshMonitors();
        Hyprland.refreshWorkspaces();
        Hyprland.refreshToplevels();
        root.scheduleSync();
    }
}
