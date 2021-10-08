
import * as WebSocket from 'ws'

export interface ExtWebSocket extends WebSocket {
    id: string
    isAlive: boolean
    upgradeReq: Request
}