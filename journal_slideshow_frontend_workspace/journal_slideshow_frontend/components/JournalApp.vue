<script setup lang="ts">
import { ref, computed } from 'vue'
import JournalSidebar from './JournalSidebar.vue'
import JournalEditor from './JournalEditor.vue'
import JournalViewer from './JournalViewer.vue'

interface Entry {
  date: string
  title: string
  content: string
}
const STORAGE_KEY = 'journal-entries-v1'

// Load entries from local storage for demo/standalone use
function loadEntries(): Entry[] {
  try {
    const v = window.localStorage.getItem(STORAGE_KEY)
    if (v) return JSON.parse(v)
  } catch {}
  return []
}
function saveEntries(entries: Entry[]) {
  window.localStorage.setItem(STORAGE_KEY, JSON.stringify(entries))
}

const entries = ref<Entry[]>(loadEntries())
const selectedIdx = ref(entries.value.length ? 0 : -1)
const editing = ref(false)
const editEntryBuffer = ref({ date: '', title: '', content: '' })
const isNew = ref(false)

function newEntry() {
  const d = new Date()
  editEntryBuffer.value = {
    date: d.toLocaleDateString('sv-SE'),
    title: '',
    content: '',
  }
  editing.value = true
  isNew.value = true
}

function selectEntry(idx: number) {
  if (editing.value) return
  selectedIdx.value = idx
}
function editCurrentEntry() {
  if (selectedIdx.value === -1) return
  editEntryBuffer.value = { ...entries.value[selectedIdx.value] }
  editing.value = true
  isNew.value = false
}
function cancelEdit() {
  editing.value = false
}
function saveEntry({ title, content }: { title: string; content: string }) {
  if (isNew.value) {
    entries.value.unshift({
      date: editEntryBuffer.value.date,
      title: title || editEntryBuffer.value.date,
      content,
    })
    selectedIdx.value = 0
  } else {
    Object.assign(entries.value[selectedIdx.value], {
      title: title || entries.value[selectedIdx.value].date,
      content,
    })
  }
  editing.value = false
  saveEntries(entries.value)
}
function nav(direction: -1 | 1) {
  const l = entries.value.length
  if (l === 0) return
  const next = selectedIdx.value + direction
  if (next >= 0 && next < l) selectedIdx.value = next
}
</script>

<template>
  <div class="app-root">
    <JournalSidebar
      :entries="entries"
      :selected="selectedIdx"
      @select="selectEntry"
      @add="newEntry"
    />
    <main class="main-content">
      <div class="main-header">
        <button
          v-if="selectedIdx !== -1 && !editing"
          class="action-btn"
          title="Edit"
          @click="editCurrentEntry"
        >
          Edit Entry
        </button>
        <button
          v-if="selectedIdx !== -1 && !editing"
          class="action-btn"
          title="Previous"
          @click="nav(-1)"
          :disabled="selectedIdx <= 0"
        >
          ‹ Prev
        </button>
        <button
          v-if="selectedIdx !== -1 && !editing"
          class="action-btn"
          title="Next"
          @click="nav(1)"
          :disabled="selectedIdx >= entries.length-1"
        >
          Next ›
        </button>
      </div>
      <div class="main-view">
        <JournalEditor
          v-if="editing"
          :value="editEntryBuffer.content"
          :title="editEntryBuffer.title"
          :date="editEntryBuffer.date"
          :editMode="!isNew"
          @save="saveEntry"
          @cancel="cancelEdit"
          @update:title="v => (editEntryBuffer.title = v)"
        />
        <template v-else>
          <JournalViewer
            v-if="selectedIdx !== -1"
            :title="entries[selectedIdx]?.title"
            :date="entries[selectedIdx]?.date"
            :content="entries[selectedIdx]?.content"
          />
          <div v-else class="empty-state">
            <img src="https://sli.dev/logo.png" class="empty-img" width="88" height="88" />
            <p>No entries yet. Click <kbd>+</kbd> to add your first journal note!</p>
          </div>
        </template>
      </div>
    </main>
  </div>
</template>

<style scoped>
.app-root {
  display: flex;
  width: 100vw;
  height: 100vh;
  background: #f8fafc;
}
.main-content {
  flex: 1 1 auto;
  display: flex;
  flex-direction: column;
  min-width: 0;
}
.main-header {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  background: #f9fafb;
  border-bottom: 1px solid #e5e7eb;
  padding: 0.55rem 1.2rem;
  min-height: 50px;
  gap: 0.6rem;
}
.action-btn {
  background: #F59E42;
  color: #fff;
  border: none;
  padding: 0.55em 1.1em;
  border-radius: 7px;
  font-weight: 600;
  cursor: pointer;
  transition: filter 0.11s;
  font-size: 1.04em;
}
.action-btn:disabled {
  background: #FFE9CB;
  color: #966;
  cursor: default;
}
.action-btn:not(:disabled):hover {
  filter: brightness(0.99) contrast(1.1);
}
.main-view {
  flex: 1 1 auto;
  overflow-y: auto;
  background: #f8fafc;
  min-height: 0;
  padding: 0 0.6vw;
  display: flex;
  align-items: flex-start;
  justify-content: center;
}
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 6rem auto;
  color: #888;
  line-height: 1.5;
}
.empty-img {
  opacity: .11;
  margin-bottom: 1.8rem;
}
</style>
