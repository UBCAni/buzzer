<template>
    <container>
        <div class="row">
            <div class="row">Hello, {{ user.name }}!</div>
            <div class="row">
                <div class="buzzer">
                    <svg>
                        <circle @click="buzz" cx="50%" cy="50%" r="125" :stroke="timer.colour" stroke-width="16" fill="white" />
                    </svg>
                </div>
            </div>
        </div>
        <answering />
        <team v-for="(team, key) in game.teams" :key="key" v-bind="team"></team>
    </container>
</template>

<script>
import Container from '@/layouts/Container'
import store from '@/store'
import { freeze } from '@/socket'
import TeamList from '@/components/TeamList'
import Answering from '@/components/Answering'

export default {
  name: 'Game',
  data () {
    return {
      user: store.state.user,
      game: store.state.game,
      timer: store.state.timer
    }
  },

  created () {
    if (this.user.visitedLobby !== true) {
      this.$router.replace('/')
    }
  },

  components: {
    container: Container,
    team: TeamList,
    answering: Answering
  },
  methods: {
    buzz () {
      if (!this.timer.disabled) {
        freeze(this.user.team, this.user.name)
      }
    }
  }
}
</script>

<style>
.buzzer {
    position: relative;
}

.buzzer svg {
    position: relative;

    width: 100%;
    height: 20rem;
}

.buzzer .timer {
    position: absolute;
    top: 25%;
    width: 100%;
}
</style>
