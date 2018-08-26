<template>
    <ul class="col s12 collapsible">
      <li :class="{ active: user.team === name }">
        <div class="collapsible-header">[{{ name }}] | Score: {{ score }} | Players: {{ players.length }}</div>
        <div class="collapsible-body">
          <li v-for="player in players" :key="player" @click="remove">
            <span>{{ player }} <i v-if="admin" @click="() => remove(name, player)" style="cursor: pointer;" class="tiny material-icons red-text">close</i></span>
          </li>
        </div>
      </li>
    </ul>
</template>

<script>
import M from 'M'
import * as socket from '@/socket'
import store from '@/store'

export default {
  name: 'TeamList',
  data () {
    return {
      user: store.state.user
    }
  },

  props: ['name', 'score', 'players', 'admin'],
  mounted () {
    M.Collapsible.init(document.querySelectorAll('.collapsible'), { accordian: false })
  },
  methods: {
    remove (team, name) {
      if (this.admin) {
        socket.removePlayer(team, name)
      }
    }
  }
}
</script>
