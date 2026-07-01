import QtQuick
import Quickshell.Services.Notifications

Item {
    id: root

    property bool doNotDisturb: false
    property ListModel notificationModel
    property ListModel popupModel

    function toggleDoNotDisturb() {
        doNotDisturb = !doNotDisturb;
        if (doNotDisturb)
            popupModel.clear();

    }

    function removeNotification(index) {
        if (index >= 0 && index < notificationModel.count) {
            let notificationId = notificationModel.get(index).id;
            notificationModel.remove(index);
            removePopupById(notificationId);
        }

    }

    function remove(index) {
        removeNotification(index);

    }

    function removePopup(index) {
        if (index >= 0 && index < popupModel.count)
            popupModel.remove(index);

    }

    function removePopupById(notificationId) {
        for (let i = popupModel.count - 1; i >= 0; i--) {
            if (popupModel.get(i).id === notificationId)
                popupModel.remove(i);
        }

    }

    NotificationServer {
        onNotification: (notification) => {
            let iconSource = notification.image || notification.appIcon || "dialog-information";
            if (iconSource.indexOf("/") === -1)
                iconSource = "image://theme/" + iconSource;
            else if (iconSource.indexOf("/") === 0)
                iconSource = "file://" + iconSource;
            let entry = {
                "id": notification.id,
                "summary": notification.summary,
                "body": notification.body,
                "icon": iconSource
            };
            root.notificationModel.insert(0, entry);
            if (!root.doNotDisturb)
                root.popupModel.insert(0, entry);

        }
    }

    notificationModel: ListModel {
    }

    popupModel: ListModel {
    }

}
