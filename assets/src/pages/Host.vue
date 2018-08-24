<template>
    <container>
      <div class="row">
        <timer class="timer"/>
      </div>
      <answering />
      <div class="row">
        <a @click="unfreeze" class="waves-effect waves-light btn">Unfreeze Timer</a>
        <a @click="() => giveScore('shiani', 1)" class="waves-effect waves-light btn">+1 Shiani</a>
        <a @click="() => giveScore('tano', 1)" class="waves-effect waves-light btn">+1 Tano</a>
        <a @click="resetQuestion" class="waves-effect waves-light btn">Next Question</a>
        <a @click="resetGame" class="waves-effect waves-light btn">Next Game</a>
      </div>
        <div class="row">
            <team :admin="true" class="col s6" v-bind="game.shiani"></team>
            <team :admin="true" class="col s6" v-bind="game.tano"></team>
        </div>
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
      timer: store.state.timer
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
      socket.resetGame()
    },

    giveScore (team, points) {
      socket.changeScore(team, points)
    }
  }
}
</script>
