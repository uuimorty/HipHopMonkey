export class WatchListDataType {
	code?: number = 0;
	data?: WatchListDataTypeData[] = [];
	msg?: string = "";
}
export class WatchListDataTypeData {
	avatar?: string = "";
	fansNum?: string = "";
	isAttention?: boolean = false;
	jokesNum?: string = "";
	nickname?: string = "";
	userId?: number = 0;
}