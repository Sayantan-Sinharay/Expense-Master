import consumer from "./consumer";

consumer.subscriptions.create("NotificationChannel", {
    connected() {
        // Called when the subscription is ready for use on the server
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        // Called when there's incoming data on the websocket for this channel
        const notificationContainer = $("#notifications-container");
        const notificationCountElement = $("#notification-count");

        const notificationCount = parseInt(notificationCountElement.text());
        if (!notificationCount) {
            notificationCountElement.addClass("flex");
        }
        notificationCountElement.text(notificationCount + 1);

        // Display the new notification
        notificationContainer.prepend(data.partial);

        // Update the notification count and display the new notification
    },
});
