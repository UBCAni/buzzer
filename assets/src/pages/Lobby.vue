<template>
    <container>
        <div class="row">
            <form class="col s12">
                <div class="row">
                    <div class="input-field col s12">
                        <input id="user" type="text" v-model="user.name" />
                        <label for="user">Username (required)</label>
                    </div>
                </div>
                <div class="row">
                    <div class="input-field col s12">
                        <select v-model="user.team">
                            <option value="" disabled selected>Choose your option</option>
                            <option value="shiani">Shiani ({{ game['shiani'].players.length }})</option>
                            <option value="tano">Tano ({{ game['tano'].players.length }})</option>
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
      game: store.state.game
    }
  },

  mounted () {
    M.FormSelect.init(document.querySelectorAll('select'), {})
  },

  methods: {
    addToGame () {
      this.user.visitedLobby = true
      addPlayer(this.user.team, this.user.name)
      this.$router.replace('game')
    }
  },

  components: {
    container: Container
  }
}
</script>
