<template>
<MkModal ref="modal" :zPriority="'high'" @click="modal?.close()" @closed="emit('closed')">
	<div class="_popup" :class="[$style.root, $style.asDrawer]">
		<MkLoading v-if="guide === ''"/>

		<Mfm :text="guide"/>
	</div>
</MkModal>
</template>

<script lang="ts" setup>
import { onMounted } from 'vue';
import MkModal from '@/components/MkModal.vue';

const modal = $shallowRef<InstanceType<typeof MkModal>>();

const emit = defineEmits<{
	(ev: 'closed'): void;
}>();

let guide = $ref('');

onMounted(async () => {
	guide = await fetch('/api/pages/show', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
		},
		body: JSON.stringify({ name: '1693552115367', username: 'Kaelz' }),
	})
		.then((response) => response.json())
		.then(({ content }) => content[0].children[0].text);
});

</script>

<style lang="scss" module>
.root {
  overflow: auto;
  width: 100%;
  height: 60vh;
	padding: 40px;
  border-radius: 24px;
  box-sizing: border-box;

  .label {
    pointer-events: none;
    font-size: 12px;
    padding-bottom: 4px;
    opacity: 0.7;
  }

  .item {
    font-size: 14px;
    padding: 10px 24px;
  }
}
</style>
