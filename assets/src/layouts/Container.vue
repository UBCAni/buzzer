<template>
    <div class="container center-align">
        <div v-if="show" class="row">
            <h1>UBCAni Reach</h1>
        </div>
        <slot></slot>
    </div>
</template>

<script>
export default {
  name: 'Container',
  props: {
    show: {
      type: Boolean,
      required: false,
      default: false
    }
  }
}
</script>
