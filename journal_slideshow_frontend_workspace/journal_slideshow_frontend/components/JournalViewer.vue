<script setup lang="ts">
// PUBLIC_INTERFACE
/**
 * JournalViewer displays a single journal entry in Markdown as a Slidev slide.
 */
import { computed } from 'vue'
const props = defineProps<{
  title: string
  date: string
  content: string
}>()
</script>

<template>
  <div class="viewer-wrap">
    <h2 class="viewer-title">{{ title || 'Untitled Entry' }}</h2>
    <span class="viewer-date">{{ date }}</span>
    <div class="viewer-markdown" v-html="$slidev?.md?.render(content) ?? ''" />
  </div>
</template>

<style scoped>
.viewer-wrap {
  max-width: 620px;
  margin: 0 auto;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 2px 12px 0 rgb(36 74 255 / 0.02);
  display: flex;
  flex-direction: column;
  padding: 2.2rem 1.2rem 2rem 1.2rem;
}
.viewer-title {
  color: #4F46E5;
  font-size: 1.36rem;
  font-weight: 700;
  margin-bottom: 0.33rem;
}
.viewer-date {
  color: #F59E42;
  font-size: 1.04rem;
  margin-bottom: 1.15rem;
  display: block;
}
.viewer-markdown {
  font-size: 1.09rem;
  color: #23272e;
  line-height: 1.75;
  margin-top: 1.2rem;
}
</style>
