<template>
    <div>
      <h3 class="col s12">{{ name }}: {{ score }}</h3>
      <ul class="col s12">
        <li v-for="player in players" :key="player" @click="remove">
          <div @click="() => remove(name, player)">
            {{ player }}
          </div>
        </li>
      </ul>
    </div>
</template>

<script>
import * as socket from '@/socket'

export default {
  name: 'TeamList',
  props: ['name', 'score', 'players', 'admin'],
  methods: {
    remove (team, name) {
      if (this.admin) {
        socket.removePlayer(team, name)
      }
    }
  }
}
</script>
