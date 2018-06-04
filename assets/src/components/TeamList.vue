<template>
    <div>
      <h2>{{ name }}</h2>
      <div>{{ score }}</div>
      <ul>
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
