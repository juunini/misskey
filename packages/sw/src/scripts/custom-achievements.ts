export function customAchievementTitle(achievement?: string): string {
	console.log(achievement, achievement, achievement, achievement, achievement);
	switch (achievement) {
		case 'visitToKaelz':
			return '총재의 프로필에 당도한 것을 환영하오, 낯선 이여';
		case 'visitToJuunini':
			return '지상 최강의 개발자?';
		case 'happyXmas2023':
			return 'HAPPY X-MAS 2023';
	}
  
	return '';
}
