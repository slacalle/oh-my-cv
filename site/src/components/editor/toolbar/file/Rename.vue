<template>
  <UiButton
    class="gap-x-1.5 w-full h-8 justify-start"
    variant="ghost"
    size="sm"
    @click="startRename"  <!-- Your rename logic here -->
  >
    <span i-material-symbols:edit-square-outline-rounded text-base />
    {{ $t("toolbar.file.rename") }}
    <span class="flex-1 tracking-widest" text="xs right muted-foreground">↵</span>
  </UiButton>

  <SharedUiEditable
    class="text-sm ml-8.5 mt-1"
    :default-value="data.resumeName"
    submit-mode="enter"
    auto-resize
    @submit="(text) => rename(text)"
  />
</template>

<script lang="ts" setup>
import { ref } from 'vue';

const { data } = useDataStore();

const isEditing = ref(false);

const startRename = () => {
  isEditing.value = true;
};

const rename = async (text?: string) => {
  if (!text || !data.resumeId) return;

  data.resumeName = text;

  await storageService.updateResume(
    {
      id: data.resumeId,
      name: text,
    },
    false
  );
};
</script>

