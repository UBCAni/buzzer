<template>
    <div>
      <h3 class="col s12">{{ name }}: {{ score }}</h3>
      <ul class="col s12">
        <li v-for="player in players" :key="player">
          {{ player }}
        </li>
      </ul>
    </div>
</template>

<script>
export default {
  name: 'TeamList',
  props: ['name', 'score', 'players']
}
</script>
