"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var WebSocket = __importStar(require("ws"));
var express_1 = __importDefault(require("express"));
var http_1 = require("http");
var player_1 = require("./wss/player");
var room_1 = require("./wss/room");
var app = (0, express_1.default)();
var server = (0, http_1.createServer)(app);
var wss = new WebSocket.Server({ server: server });
var port = 3000;
var playerQeue = new Array();
var rooms = new Array();
wss.on('connection', function (ws) {
    ws.send('Searching for an opponent...');
    ws.on('message', function (message) {
        var data = JSON.parse(message);
        switch (data.type) {
            case 'onConnect':
                var me_1 = new player_1.Player(data.message, ws);
                playerQeue.push(me_1);
                if (me_1.id !== playerQeue[0].id) {
                    var players = [
                        me_1,
                        playerQeue[0]
                    ];
                    rooms.push(new room_1.Room(players));
                    playerQeue = playerQeue.filter(function (player) { return player.id !== me_1.id || player.id !== playerQeue[0].id; });
                }
        }
    });
});
server.listen(port, function () {
    console.log("Server listening on Port: " + port + "...");
});
//# sourceMappingURL=server.js.map