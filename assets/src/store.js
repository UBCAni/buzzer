import Vue from 'vue'

export default {
  state: {
    timer: {
      countdown: false,
      disabled: true,
      colour: '#FFCD6B'
    },

    answering: {
      name: null
    },

    user: { team: '', name: '' },

    game: {}
  },

  init (game) {
    this.state.game.teams = game
  },

  addPlayer (team, player) {
    this.state.game.teams[team].players.push(player)
  },

  removePlayer (team, player) {
    const players = this.state.game.teams[team].players

    players.splice(players.indexOf(player), 1)

    if (player === this.state.user.name) {
      window.location = '/'
    }
  },

  addTeam (team) {
    Vue.set(this.state.game.teams, team, { name: team, players: [], score: 0, buzzed: false })
  },

  removeTeam (team) {
    Vue.delete(this.state.game.teams, team)
    if (this.state.user.team === team) {
      window.location = '/'
    }
  },

  adjustScore (team, score) {
    this.state.game.teams[team].score = score
  },

  freeze (team, answering) {
    this.state.timer.disabled = true
    this.state.timer.countdown = false
    this.state.answering.name = `[${team}] ${answering}`
    this.state.game.teams[team].buzzed = true

    if (answering === this.state.user.name) {
      this.state.timer.colour = '#7962C9'
      if (navigator.vibrate) {
        navigator.vibrate(500)
      }
    } else {
      this.state.timer.colour = '#FFCD6B'
    }
  },

  unfreeze () {
    this.state.answering.name = null
    this.state.timer.countdown = true
    this.state.timer.disabled = false
    this.state.timer.colour = '#4EBBB7'
  },

  resetQuestion () {
    this.state.answering.name = null
    this.state.timer.countdown = null
    this.state.timer.disabled = true
    this.state.timer.colour = '#FFCD6B'

    for (const value of Object.values(this.state.game.teams)) {
      value.buzzed = false
    }
  },

  resetGame () {
    for (const value of Object.values(this.state.game.teams)) {
      value.score = 0
    }

    this.resetQuestion()
  }
}
