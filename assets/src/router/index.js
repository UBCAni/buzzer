import Vue from 'vue'
import Router from 'vue-router'

import Host from '@/pages/Host'
import Lobby from '@/pages/Lobby'
import Game from '@/pages/Game'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Lobby',
      component: Lobby
    },
    {
      path: '/admin',
      name: 'Host',
      component: Host
    },
    {
      path: '/game',
      name: 'Game',
      component: Game
    }
  ]
})
