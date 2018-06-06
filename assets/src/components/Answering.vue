<template>
    <div class="row" v-show="answering.name !== null">Now answering: {{ answering.name }}</div>
</template>

<script>
import store from '@/store'

export default {
  name: 'Answering',
  data () {
    return {
      answering: store.state.answering
    }
  }
}
</script>
