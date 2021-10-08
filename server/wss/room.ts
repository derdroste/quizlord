import {Player} from './player'
import { v4 as uuidv4 } from 'uuid';
import { ExtWebSocket } from '../interfaces/ExtWebSocket';

export class Room {
    players: Array<Player>
    id: string

    constructor(players: Array<Player>) {
        this.players = players
        this.id = uuidv4()

        for (let player of this.players) {
            this.sendMessage(player.client, `${player.id} connected to ${this.id}...`)
            console.log(`${player.id} connected to ${this.id}...`)
        }
    }

    sendMessage(client: ExtWebSocket, message: string) {
        client.send(message)
    }
}