<template>
  <div id="q-app">
    <router-view />
  </div>
</template>

<script>
import { APP } from './APP'
import { mapGetters } from 'vuex'

export default {
  name: 'App',
  components: {
    PlatformPanel
  },
  computed: {
    ...mapGetters('core', { coreVersion: 'version' }),
  },
  beforeCreate () {
    // Set vue instance
    APP.vue = () => this.$root

    // debug
    console.log('Quasar -> ', this.$q.version)
  },
  watch: {
  }
}
</script>

<style>
</style>
