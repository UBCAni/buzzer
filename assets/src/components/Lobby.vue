<template>
    <div class="row">
        <form class="col s12">
            <div class="row">
                <div class="input-field col s12">
                    <input id="user" type="text" v-model="name" />
                    <label for="user">Username (required)</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s12">
                    <select v-model="selected">
                        <option value="" disabled selected>Choose your option</option>
                        <option value="shiani">Shiani</option>
                        <option value="tano">Tano</option>
                    </select>
                    <label>Team</label>
                </div>
            </div>
            <a class="waves-effect waves-light btn-large" @click="addToGame" :disabled="name === '' || selected === ''">Join Game</a>
            <a class="waves-effect waves-light btn-large" @click="$emit('host')">Host Game</a>
        </form>
    </div>
</template>

<script>
import M from 'M'
import { channel } from '../socket'

export default {
  name: 'Lobby',
  data () {
    return {
      name: '',
      selected: ''
    }
  },

  mounted () {
    M.FormSelect.init(document.querySelectorAll('select'), {})
  },

  methods: {
    addToGame () {
      channel.push('player_joined', { team: this.selected, name: this.name })
        .receive('ok', () => {
          this.$emit('game')
        })
    }
  }
}
</script>
