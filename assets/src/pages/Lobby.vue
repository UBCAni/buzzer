<template>
    <container :show=true>
        <div v-if="this.error" class="red-text">{{ error }}</div>
        <div class="row">
            <form class="col s12">
                <div class="row">
                    <div class="input-field col s12">
                        <input id="user" type="text" v-model="user.name" />
                        <label class="active" for="user">Username (required)</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <select v-model="user.team">
                            <option value="" disabled selected>Choose your team</option>
                            <option v-for="(team, key) in game.teams" :key="key" :value="key">{{key}} ({{ team.players.length }})</option>
                        </select>
                        <label>Team</label>
                    </div>
                </div>
            </form>
        </div>
        <div class="row">
            <a class="waves-effect waves-light btn-large" @click="addToGame" :disabled="user.name === '' || user.team === ''">Join Game</a>
            <a class="waves-effect waves-light btn-large" @click="() => this.$router.push('admin')">Host Game</a>
        </div>
    </container>
</template>

<script>
import M from 'M'
import { addPlayer } from '@/socket'
import store from '@/store'
import Container from '@/layouts/Container'

export default {
  name: 'Lobby',
  data () {
    return {
      user: store.state.user,
      game: store.state.game,
      error: ''
    }
  },

  mounted () {
    M.FormSelect.init(document.querySelectorAll('select'), {})
  },

  methods: {
    addToGame () {
      if (Object.values(this.game.teams).some((team) => team.players.includes(this.user.name))) {
        this.error = 'This name is already in use.'
      } else {
        this.user.visitedLobby = true
        addPlayer(this.user.team, this.user.name)
        this.$router.replace('game')
      }
    }
  },

  components: {
    container: Container
  }
}
</script>
