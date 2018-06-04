import * as Phoenix from 'phoenix'

const socket = new Phoenix.Socket('ws://localhost:4000/socket')
socket.connect()

export const channel = socket.channel('game:default')
