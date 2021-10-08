import WebSocket, { WebSocketServer } from "ws"

interface ExtWebSocket extends WebSocket {
    id: string
    isAlive: boolean
    upgradeReq: Request
}

const SocketServer = (wss: WebSocketServer) => {
    wss.on('connection', (ws: ExtWebSocket, req: Request) => {
        ws.upgradeReq = req;
        console.log(`Client connected...`);

        ws.on('message', (message: string) => {
            const data = JSON.parse(message);
            ws.id = data.roomId;
            ws.isAlive = true;

            ws.on('pong', () => {
                ws.isAlive = true;
            });

            switch (data.message) {
                case 'join-room':
                    broadcastToRooms(
                        wss,
                        ws,
                        'user-connected',
                        data.userId
                    );
                    break;
            }
            ws.on('close', () => {
                broadcastToRooms(
                    wss,
                    ws,
                    'user-disconnected',
                    data.userId
                );
            }); 
        });
    })
}

const broadcastToRooms = (wss: WebSocketServer, ws: ExtWebSocket, message: string, userId: string) => {
    wss.clients.forEach(client => {
        // @ts-ignore
        if (client.upgradeReq.url === ws.upgradeReq.url && client.id === ws.id) {
            if (client !== ws && client && client.readyState === ws.OPEN) {
                client.send(JSON.stringify(
          {
                    message,
                    userId
                }));
            }
        }
    });
}

export {SocketServer}