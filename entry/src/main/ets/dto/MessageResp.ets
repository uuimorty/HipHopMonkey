export class MessageResp {
	code?: number = 0;
	data?: MessageRespData[] = [];
	msg?: string = "";
}
export class MessageRespData {
	commentId?: number = 0;
	content?: string = "";
	extraContent?: string = "";
	msgId?: number = 0;
	msgItemType?: number = 0;
	msgItemTypeDesc?: string = "";
	msgMainType?: number = 0;
	msgMainTypeDesc?: string = "";
	msgStatus?: number = 0;
	msgTime?: string = "";
	ownerUserId?: number = 0;
	targetId?: number = 0;
	targetNickname?: string = "";
	targetUserAvatar?: string = "";
	targetUserId?: number = 0;
}

export class MessageReq {
	page: string='1'
	type: '0'|'1'|'2' ='0'
	constructor(page:string,type:'0'|'1'|'2') {
		this.page=page
		this.type=type
	}
}