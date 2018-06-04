// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import { channel } from './socket'

channel.on('new_team', console.log)
channel.on('player_joined', console.log)
channel.on('team_scored', console.log)
channel.on('freeze', console.log)
channel.on('unfreeze', console.log)
channel.on('reset:question', console.log)
channel.on('reset:game', console.log)
channel.on('state', (data) => {
  /* eslint-disable no-new */
  Vue.config.productionTip = false
  console.log(data)

  new Vue({
    el: '#app',
    router,
    components: { App },
    template: '<App/>',
    propsData: {
      game: data
    }
  })
})

channel.join()
