import * as WebSocket from 'ws'
import express from 'express'
import { createServer } from 'http'
import {ExtWebSocket} from './interfaces/ExtWebSocket'
import {Player} from './wss/player'
import {Room} from './wss/room'

const app = express()
const server = createServer(app)
const wss = new WebSocket.Server({ server })
const port = 3000

let playerQeue = new Array<Player>()
const rooms = new Array<Room>()

wss.on('connection', (ws: ExtWebSocket) => {
    ws.send('Searching for an opponent...')

    ws.on('message', (message: string) => {
        const data = JSON.parse(message)

        switch (data.type) {
            case 'onConnect':
                const me = new Player(data.message, ws)
                playerQeue.push(me)

                if (me.id !== playerQeue[0].id) {
                    const players = [
                        me,
                        playerQeue[0]
                    ]
                    rooms.push(new Room(players))
                    playerQeue = playerQeue.filter(player => player.id !== me.id || player.id !== playerQeue[0].id)
                }
        }
    })
    
})

server.listen(port, () => {
    console.log(`Server listening on Port: ${port}...`)
})
