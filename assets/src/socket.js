import * as Phoenix from 'phoenix'
import store from './store'

const socket = new Phoenix.Socket(process.env.NODE_ENV === 'production'
  ? 'wss://buzzer.moso.moe/socket'
  : 'ws://localhost:4000/socket')

socket.connect()

export const channel = socket.channel('game:default')

export function init (func) {
  channel.on('disconnected', ({ team, name }) => store.removePlayer(team, name))
  channel.on('add:team', ({ team }) => store.addTeam(team))
  channel.on('remove:team', ({ team }) => store.removeTeam(team))
  channel.on('add:player', ({ team, name }) => store.addPlayer(team, name))
  channel.on('change:score', ({ team, points }) => store.adjustScore(team, points))
  channel.on('freeze', ({ team, name }) => store.freeze(team, name))
  channel.on('unfreeze', () => store.unfreeze())
  channel.on('reset:question', () => store.resetQuestion())
  channel.on('reset:game', () => store.resetGame())
  channel.on('state', func)

  channel.join()
}

export function addPlayer (team, name) {
  return channel.push('add:player', { team, name })
}

export function changeScore (team, points) {
  return channel.push('change:score', { team, points })
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

export function removePlayer (team, name) {
  return channel.push('remove:player', { team, name })
}

export function addTeam (team) {
  return channel.push('add:team', { team })
}

export function removeTeam (team) {
  return channel.push('remove:team', { team })
}
