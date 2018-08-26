<template>
    <container>
      <div class="row">
        <timer class="timer"/>
      </div>
      <answering />
      <div class="row">
        <a @click="unfreeze" class="waves-effect waves-light btn">Unfreeze</a>
        <a @click="resetQuestion" class="waves-effect waves-light btn">Reset Timer</a>
        <a @click="resetGame" class="waves-effect waves-light btn">Reset Game</a>
      </div>
      <div v-for="(team, key) in game.teams" :key="key">
        <team :admin="true" v-bind="team"></team>
        <a @click="() => giveScore(key, 1)" class="waves-effect waves-light btn">+1</a>
        <a @click="() => giveScore(key, -1)" class="waves-effect waves-light btn">-1</a>
        <a @click="() => removeTeam(key)" class="waves-effect waves-light btn red">Delete</a>
      </div>
      <form action="#" class="row">
        <div class="file-field input-field">
          <div class="waves-effect waves-light btn" @click="addTeam" :disabled="team === '' || game.teams[team]">
            <span>Add</span>
          </div>
          <div class="file-path-wrapper">
            <input id="team" type="text" v-model="team" />
          </div>
        </div>
      </form>
    </container>
</template>

<script>
import Container from '@/layouts/Container'
import Timer from '@/components/Timer'
import Answering from '@/components/Answering'
import TeamList from '@/components/TeamList'

import store from '@/store'
import * as socket from '@/socket'

export default {
  name: 'Host',
  data () {
    return {
      game: store.state.game,
      timer: store.state.timer,
      team: ''
    }
  },
  components: {
    container: Container,
    timer: Timer,
    answering: Answering,
    team: TeamList
  },

  methods: {
    unfreeze () {
      socket.unfreeze()
    },

    resetQuestion () {
      socket.resetQuestion()
    },

    resetGame () {
      if (confirm('Reset score?')) {
        socket.resetGame()
      }
    },

    giveScore (team, points) {
      socket.changeScore(team, points)
    },

    addTeam () {
      socket.addTeam(this.team)
      this.team = ''
    },

    removeTeam (team) {
      if (confirm('Remove this team?')) {
        socket.removeTeam(team)
      }
    }
  }
}
</script>
