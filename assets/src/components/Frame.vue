<template>
    <div class="container">
        <div class="row">
            <h1>UBCAni Reach</h1>
        </div>
        <component @game="loadGame" @host="loadHostPanel" :is="currentComponent"></component>
    </div>
</template>

<script>
import Lobby from './Lobby'
import Host from './Host'
import Game from './Game'

export default {
  name: 'Frame',
  data () {
    return {
      currentComponent: Lobby
    }
  },

  methods: {
    loadGame () {
      this.currentComponent = Game
    },

    loadHostPanel () {
      this.currentComponent = Host
    }
  }
}
</script>
