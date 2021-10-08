"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Room = void 0;
var uuid_1 = require("uuid");
var Room = (function () {
    function Room(players) {
        this.players = players;
        this.id = (0, uuid_1.v4)();
        for (var _i = 0, _a = this.players; _i < _a.length; _i++) {
            var player = _a[_i];
            this.sendMessage(player.client, player.id + " connected to " + this.id + "...");
            console.log(player.id + " connected to " + this.id + "...");
        }
    }
    Room.prototype.sendMessage = function (client, message) {
        client.send(message);
    };
    return Room;
}());
exports.Room = Room;
//# sourceMappingURL=room.js.map