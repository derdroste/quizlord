import {ExtWebSocket} from '../interfaces/ExtWebSocket'

export class Player {
    id: string
    client: ExtWebSocket

    constructor(id: string, client: ExtWebSocket) {
        this.id = id
        this.client = client
    } 
}