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

    user: {
      team: localStorage.getItem('team') || '',
      name: localStorage.getItem('name') || ''
    },

    game: {}
  },

  init (game) {
    this.state.game = game
  },

  addPlayer (team, player) {
    this.state.game[team].players.push(player)
  },

  removePlayer (team, player) {
    const players = this.state.game[team].players

    players.splice(players.indexOf(player), 1)
  },

  adjustScore (team, score) {
    this.state.game[team].score = score
  },

  freeze (answering) {
    this.state.timer.disabled = true
    this.state.timer.countdown = false
    this.state.answering.name = answering
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
  },

  resetGame () {
    for (const value of Object.values(this.state.game)) {
      value.score = 0
    }

    this.resetQuestion()
  }
}
