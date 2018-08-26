<template>
    <div class="row" v-if="answering.name !== null">Now answering: {{ answering.name }}.
    </div>
</template>

<script>
import VueCountdown from '@xkeshi/vue-countdown'
import store from '@/store'

export default {
  name: 'Answering',
  data () {
    return {
      answering: store.state.answering
    }
  },

  components: {
    countdown: VueCountdown
  }
}
</script>
