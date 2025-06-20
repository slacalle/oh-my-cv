<template>
  <UiTooltipProvider :delay-duration="0">
    <UiTooltip>
      <UiTooltipTrigger as-child>
        <UiButton
          class="gap-x-1.5 w-full h-8 justify-start"
          variant="ghost"
          size="sm"
          @click="exportPDF"
        >
          <span i-mdi:file-pdf text-base />
          {{ $t("toolbar.file.export_pdf.title") }}
        </UiButton>
      </UiTooltipTrigger>
    </UiTooltip>
  </UiTooltipProvider>

  <UiButton
    class="gap-x-1.5 w-full h-8 justify-start"
    variant="ghost"
    size="sm"
    @click="exportMd"
  >
    <span i-ri:markdown-fill text-base />
    {{ $t("toolbar.file.export_md") }}
  </UiButton>

  <UiButton
  class="gap-x-1.5 w-full h-8 justify-start"
  variant="ghost"
  size="sm"
  @click="exportCSS"
>
  <span i-mdi:language-css3 text-base />
  {{ $t("toolbar.file.export_css") }}
</UiButton>
</template>

<script lang="ts" setup>
import { downloadFile } from "@renovamen/utils";

const { data } = useDataStore();
const saveName = computed(() => data.resumeName.trim().replace(/\s+/g, "_"));

// Export as PDF
const exportPDF = () => {
  const title = document.title;

  document.title = saveName.value;
  window.print();
  document.title = title;
};

// Export as Markdown
const exportMd = () => {
  downloadFile(`${saveName.value}.md`, data.markdown);
};

// Export CSS
const exportCSS = () => {
  downloadFile(`${saveName.value}.css`, data.css);
};
</script>
