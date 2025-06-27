<script setup lang="ts">
import { ref, watch, computed } from 'vue'

const props = defineProps<{
  entries: { date: string; title: string; content: string }[]
  selected: number
}>()
const emit = defineEmits(['select', 'add'])

const search = ref('')
const filteredEntries = computed(() =>
  props.entries.filter(
    e =>
      e.title.toLowerCase().includes(search.value.toLowerCase()) ||
      e.content.toLowerCase().includes(search.value.toLowerCase()),
  ),
)
</script>

<template>
  <aside class="sidebar">
    <div class="sidebar-header">
      <h2 class="logo">Journal</h2>
      <button class="add-btn" @click="$emit('add')">
        +
      </button>
    </div>
    <input
      v-model="search"
      placeholder="Search entries..."
      class="sidebar-search"
    />
    <nav class="sidebar-list">
      <div
        v-for="(entry, idx) in filteredEntries"
        :key="entry.date"
        class="sidebar-entry"
        :class="{ selected: idx === props.selected }"
        @click="$emit('select', idx)"
        tabindex="0"
      >
        <div class="entry-title">{{ entry.title || entry.date }}</div>
        <div class="entry-date">{{ entry.date }}</div>
      </div>
    </nav>
  </aside>
</template>

<style scoped>
.sidebar {
  width: 240px;
  background: #fff;
  border-right: 1px solid #eee;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  padding: 0 0.75rem;
}
.sidebar-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 1rem 0 0.5rem 0;
}
.logo {
  margin: 0;
  font-size: 1.5rem;
  color: #4F46E5;
  letter-spacing: 1px;
  font-weight: 600;
}
.add-btn {
  background: #10B981;
  border: none;
  color: white;
  font-size: 1.4rem;
  border-radius: 6px;
  width: 2.2rem;
  height: 2.2rem;
  cursor: pointer;
  display: flex; align-items: center; justify-content: center;
  transition: opacity .2s;
}
.add-btn:hover { opacity: 0.88 }
.sidebar-search {
  width: 100%;
  padding: 0.5rem 0.75rem;
  margin-bottom: 0.7rem;
  border: 1px solid #e5e7eb;
  border-radius: 6px;
  outline: none;
  font-size: 1rem;
}
.sidebar-list {
  flex: 1 1 auto;
  overflow-y: auto;
  padding-bottom: 1rem;
}
.sidebar-entry {
  padding: 0.7rem 0.6rem 0.6rem 0.7rem;
  border-radius: 5px;
  cursor: pointer;
  margin-bottom: 0.15rem;
  transition: background 0.17s;
}
.sidebar-entry.selected, .sidebar-entry:focus {
  background: #f3f4f6;
  border-left: 4px solid #10B981;
}
.sidebar-entry:hover:not(.selected) {
  background: #f9fafb;
}
.entry-title {
  font-size: 1rem;
  font-weight: 500;
  color: #111;
  margin-bottom: 1px;
}
.entry-date {
  font-size: 0.83rem;
  color: #94A3B8;
}
</style>
