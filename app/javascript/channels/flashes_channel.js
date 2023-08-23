import consumer from "./consumer";

consumer.subscriptions.create("FlashesChannel", {
    connected() {
        // Called when the subscription is ready for use on the server
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        const flashesContainer = $("#flashes-container");
        flashesContainer.append(data);
    },
});
