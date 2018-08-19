<template>
  <countdown v-if="timer.countdown !== null" tag="p" :time="10000" :interval="1000" :leading-zero="false" :auto-start="false" ref="countdown">
      <template slot-scope="props">
          <span class="seconds">{{ props.seconds }}</span>
      </template>
  </countdown>
</template>

<script>
import VueCountdown from '@xkeshi/vue-countdown'
import store from '@/store'
export default {
  name: 'Timer',
  data () {
    return {
      timer: store.state.timer
    }
  },
  components: {
    countdown: VueCountdown
  },

  watch: {
    'timer.countdown' (value, oldValue) {
      if (value === null) {
        this.$nextTick(() => {
          this.timer.countdown = false
        })
      } else if (value !== oldValue && this.$refs.countdown !== undefined) {
        // if beginning countdown
        if (value) {
          this.$refs.countdown.start()
        } else {
          this.$refs.countdown.pause()
        }
      }
    }
  }
}
</script>

<style>
  .seconds {
    font-size: 5rem;
  }
</style>
