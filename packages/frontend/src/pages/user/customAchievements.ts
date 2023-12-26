import { claimAchievement } from '@/scripts/achievements.js';

export type CustomAchievementType = 'visitToKaelz' | 'visitToJuunini';

export const customAchievementTypes = [
	'visitToKaelz',
	'visitToJuunini',
	'happyXmas2023',
	'happyNewYear2024',
];

export const customAchievementBadges = {
	'visitToKaelz': {
		img: 'https://storage.googleapis.com/yodangang-express/images/kaelz.webp',
		bg: '#000000',
		frame: 'bronze',
	},
	'visitToJuunini': {
		img: 'https://storage.googleapis.com/yodangang-express/images/juunini.webp',
		bg: '#000000',
		frame: 'bronze',
	},
	'happyXmas2023': {
		img: 'https://storage.googleapis.com/yodangang-express/images/xmas2023.webp',
		bg: '#ffffff',
		frame: 'silver',
	},
	'happyNewYear2024': {
		img: 'https://storage.googleapis.com/yodangang-express/images/happyNewYear2024.webp',
		bg: '#000000',
		frame: 'bronze',
	},
};

export async function customAchievementsInUsers(user: Record<string, any>): Promise<void> {
	switch (user.username) {
		case 'Kaelz':
			await claimAchievement('visitToKaelz');
			return;
		case 'juunini':
			await claimAchievement('visitToJuunini');
			return;
	}
}

export async function customAchievementsInMainBoot(): Promise<void> {
	const today = new Date(Date.now());
	const year = today.getFullYear();
	const month = today.getMonth();
	const day = today.getDate();

	if (year === 2023 && month === 11 && (day === 24 || day === 25)) {
		await claimAchievement('happyXmas2023');
	}

	if (year === 2024 && month === 0 && day === 1) {
		await claimAchievement('happyNewYear2024');
	}
}

export function customAchievementTitle(achievement?: string): string {
	switch (achievement) {
		case 'visitToKaelz':
			return '총재의 프로필에 당도한 것을 환영하오, 낯선 이여';
		case 'visitToJuunini':
			return '지상 최강의 개발자?';
		case 'happyXmas2023':
			return 'HAPPY X-MAS 2023';
		case 'happyNewYear2024':
			return 'HAPPY NEW YEAR!';
	}
	return '';
}

export function customAchievementDescription(achievement: string): string {
	switch (achievement) {
		case 'visitToKaelz':
			return '요단강 익스프레스 운영자 악덕총재의 미스키 프로필을 확인했습니다.';
		case 'visitToJuunini':
			return '지상 최강의 개발자 쥬니니의 프로필을 확인했습니다';
		case 'happyXmas2023':
			return '2023년 크리스마스에 접속하셨습니다.';
		case 'happyNewYear2024':
			return '2024년 1월 1일에 접속했습니다.';
	}
	return '';
}

export function customAchievementFlavor(achievement: string): string {
	switch (achievement) {
		case 'visitToKaelz':
			return '근데... 팔로우 버튼 눌렀니?';
		case 'happyXmas2023':
			return '메리 크리스마스!';
		case 'happyNewYear2024':
			return '새해 복 많이 받으세요!';
	}
	return '';
}
