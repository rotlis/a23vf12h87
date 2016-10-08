function WebSocketBuilder() {
    WebSocketBuilder.prototype.onDocReady = function () {
        toastr.options.preventDuplicates = true;
        toastr.info('Connecting...');
        this.connect(this);
    };

    WebSocketBuilder.prototype.getWebSocketUrl = function (s) {
        var location = window.location;
        var protocol = location.protocol === "https:" ? "wss://" : "ws://";
        var port = location.port !== "80" && location.port !== "443" ? ":" + location.port : "";
        return protocol + location.hostname + port + s;
    };

    WebSocketBuilder.prototype.connect = function (that) {
        var webSocketUrl = that.getWebSocketUrl("/ws/test");
        console.debug(webSocketUrl);

        var ws = new WebSocket(webSocketUrl);
        ws.onmessage = function (event) {
            console.debug("onmessage", event.data);
            onNodeBeackon($.parseJSON(event.data));
        };
        ws.onopen = function () {
            console.debug("Connection is open");
            toastr.remove();
            toastr.success('Connected');
        };
        ws.onclose = function () {
            console.debug("Connection is closed...");
            toastr.error('Connection closed. Reconnecting ....');
            setTimeout(that.connect(that), 1000);
        };
    };
}


$(document).ready(function () {
    var webSocket = new WebSocketBuilder();
    webSocket.onDocReady();
});
