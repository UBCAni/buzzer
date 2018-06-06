import * as Phoenix from 'phoenix'
import store from './store'

const socket = new Phoenix.Socket(process.env.NODE_ENV === 'production'
  ? 'wss://buzzer.ubcani.com/socket'
  : 'ws://localhost:4000/socket')

socket.connect()

export const channel = socket.channel('game:default')

export function init (func) {
  channel.on('disconnected', ({ team, name }) => store.removePlayer(team, name))
  channel.on('player_joined', ({ team, name }) => store.addPlayer(team, name))
  channel.on('team_scored', ({ team, points }) => store.adjustScore(team, points))
  channel.on('freeze', ({ name }) => store.freeze(name))
  channel.on('unfreeze', () => store.unfreeze())
  channel.on('reset:question', () => store.resetQuestion())
  channel.on('reset:game', () => store.resetGame())
  channel.on('state', func)

  channel.join()
}

export function addPlayer (team, name) {
  localStorage.setItem('team', team)
  localStorage.setItem('name', name)

  return channel.push('player_joined', { team, name })
}

export function changeScore (team, points) {
  return channel.push('team_scored', { team, points })
}

export function freeze (team, name) {
  return channel.push('freeze', { team, name })
}

export function unfreeze () {
  return channel.push('unfreeze')
}

export function resetQuestion () {
  return channel.push('reset:question')
}

export function resetGame () {
  return channel.push('reset:game')
}
