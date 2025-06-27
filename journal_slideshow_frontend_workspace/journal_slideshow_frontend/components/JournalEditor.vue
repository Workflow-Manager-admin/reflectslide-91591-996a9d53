<script setup lang="ts">
import { ref, onMounted, watch } from 'vue'
const props = defineProps<{
  value: string
  title: string
  date: string
  editMode: boolean
}>()
const emit = defineEmits(['update:value', 'save', 'cancel', 'update:title'])
const localContent = ref(props.value)
const localTitle = ref(props.title)

watch(
  () => props.value,
  v => (localContent.value = v),
)
watch(
  () => props.title,
  v => (localTitle.value = v),
)
onMounted(() => {
  localContent.value = props.value
  localTitle.value = props.title
})

function handleSave() {
  emit('save', { title: localTitle.value, content: localContent.value })
}
</script>

<template>
  <div class="editor-wrap">
    <div class="editor-header">
      <input
        v-model="localTitle"
        class="editor-title"
        :placeholder="editMode ? 'Edit Title...' : 'Entry Title...'"
      />
      <span class="editor-date">{{ date }}</span>
    </div>
    <textarea
      v-model="localContent"
      class="editor-textarea"
      rows="12"
      spellcheck="true"
      :placeholder="editMode ? 'Edit entry in Markdown...' : 'Write your journal in Markdown...'"
      @keydown.enter.ctrl.exact.prevent="handleSave"
    />
    <div class="editor-actions">
      <button class="save-btn" @click="handleSave">Save</button>
      <button class="cancel-btn" @click="$emit('cancel')">Cancel</button>
    </div>
  </div>
</template>

<style scoped>
.editor-wrap {
  padding: 2.2rem 1.2rem 0.3rem 1.2rem;
  max-width: 620px;
  margin: 0 auto;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 2px 12px 0 rgb(36 74 255 / 0.02);
  display: flex;
  flex-direction: column;
}
.editor-header {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  margin-bottom: 1rem;
  gap: 1.3rem;
}
.editor-title {
  font-size: 1.4rem;
  font-weight: 600;
  border: none;
  outline: none;
  background: transparent;
  color: #4F46E5;
  flex: 1 1 auto;
}
.editor-date {
  color: #F59E42;
  font-size: 1.02rem;
  padding-right: 0.7rem;
}
.editor-textarea {
  width: 100%;
  border: 1px solid #E5E7EB;
  border-radius: 7px;
  padding: 1.1rem 1.2rem;
  font-size: 1.07rem;
  min-height: 12em;
  font-family: 'Fira Mono', 'Consolas', 'monospace';
  outline: none;
  margin-bottom: 1.25rem;
  transition: border 0.14s;
  resize: vertical;
  background: #fafafe;
  color: #22223B;
}
.editor-textarea:focus {
  border-color: #10B981;
  background: #f9fefb;
}
.editor-actions {
  display: flex;
  align-items: center;
  gap: 8px;
}
.save-btn, .cancel-btn {
  padding: 0.57em 1.38em;
  border-radius: 7px;
  border: none;
  font-size: 1.07rem;
  cursor: pointer;
  transition: background 0.13s;
}
.save-btn {
  background: #10B981;
  color: #fff;
  font-weight: 600;
}
.save-btn:hover {
  background: #059669;
}
.cancel-btn {
  background: #e0e7ef;
  color: #444;
  font-weight: 500;
}
.cancel-btn:hover {
  background: #f3f4f6;
}
</style>
