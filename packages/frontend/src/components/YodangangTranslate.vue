<template>
<button
	v-if="props.note.text && !/[가-힣]/g.test(props.note.text)"
	:class="$style.translate"
	:disabled="translation != null"
	@click="translate"
>
	{{ i18n.ts.translate }}
</button>
</template>

<script lang="ts" setup>
import { Ref, inject } from 'vue';
import * as Misskey from 'misskey-js';
import { miLocalStorage } from '@/local-storage.js';
import { i18n } from '@/i18n.js';
import * as os from '@/os.js';

const props = defineProps<{
  note: Misskey.entities.Note;
}>();

const translating = inject<Ref<boolean>>('translating');
const translation = inject<Ref<string | null>>('translation');

async function translate(): Promise<void> {
	if (translation?.value != null) return;

	translating!.value = true;
	const res = await os.api('notes/translate', {
		noteId: props.note.id,
		targetLang: miLocalStorage.getItem('lang') ?? navigator.language,
	});

	translating!.value = false;
	translation!.value = res;
}
</script>

<style lang="scss" module>
.translate {
  display: flex;
  margin: 0;
  margin-top: 10px;
  margin-bottom: 10px;
  padding: 0;
  color: var(--navActive);
  border: none;
  background: none;
  text-decoration: underline;
  cursor: pointer;

  &:disabled {
    display: none;
  }
}
</style>
