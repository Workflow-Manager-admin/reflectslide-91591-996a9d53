<script setup lang="ts">
// PUBLIC_INTERFACE
/**
 * Custom layout: renders the main JournalApp as a fullscreen app in Slidev.
 */
import JournalApp from '../components/JournalApp.vue'
</script>

<template>
  <JournalApp />
</template>

<style scoped>
/* Full override: no padding, no classic slide look. */
:host, .slidev-layout {
  background: #f8fafc !important;
  min-height: 100vh;
  padding: 0;
  margin: 0;
}
</style>
