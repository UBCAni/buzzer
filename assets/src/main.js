// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import { init } from './socket'
import store from './store'

init((data) => {
  /* eslint-disable no-new */
  Vue.config.productionTip = false
  store.init(data)

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
