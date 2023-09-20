<!--
SPDX-FileCopyrightText: syuilo and misskey-project
SPDX-License-Identifier: AGPL-3.0-only
-->

<template>
<div v-if="hasDisconnected && defaultStore.state.serverDisconnectedBehavior === 'quiet'" :class="$style.root" class="_panel _shadow" @click="resetDisconnected">
	<MkButton small primary rounded :class="$style.refreshButton" :aria-label="i18n.ts.reload" @click="reload">
		<i class="ti ti-refresh"></i>
	</MkButton>
</div>
</template>

<script lang="ts" setup>
import { onUnmounted, ref } from 'vue';
import { useStream } from '@/stream.js';
import { i18n } from '@/i18n.js';
import MkButton from '@/components/MkButton.vue';
import * as os from '@/os.js';
import { defaultStore } from '@/store.js';

const zIndex = os.claimZIndex('high');

const hasDisconnected = ref(false);

function onDisconnected() {
	hasDisconnected.value = true;
}

function resetDisconnected() {
	hasDisconnected.value = false;
}

function reload() {
	location.reload();
}

useStream().on('_disconnected_', onDisconnected);

onUnmounted(() => {
	useStream().off('_disconnected_', onDisconnected);
});
</script>

<style lang="scss" module>
.root {
	position: fixed;
	z-index: v-bind(zIndex);
	bottom: calc(var(--minBottomSpacing) + var(--margin));
	right: var(--margin);
	margin: 0;
	padding: 12px;
	font-size: 0.9em;
	max-width: 320px;
}

.command {
	margin-top: 8px;
}

.refreshButton {
	display: flex;
	min-width: 40px !important;
	width: 40px;
	height: 40px;
	align-items: center;
	justify-content: center;
}
</style>
