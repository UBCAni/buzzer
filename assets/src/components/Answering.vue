<template>
    <div class="row" v-if="answering.name !== null">Now answering: {{ answering.name }}. Time remaining:
      <countdown :time="5000" :leading-zero="false" :interval="1000">
          <template slot-scope="props">
              <span>{{ props.seconds }}</span>
          </template>
      </countdown>
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
