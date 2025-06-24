export class FreshPage {
	code?: number = 0;
	data?: FreshPageData[] = [];
	msg?: string = "";

}
export class FreshPageDataInfo {
	commentNum?: number = 0;
	disLikeNum?: number = 0;
	isAttention?: boolean = false;
	isLike?: boolean = false;
	isUnlike?: boolean = false;
	likeNum?: number = 0;
	shareNum?: number = 0;
}
export class FreshPageDataJoke {
	addTime?: string = "";
	audit_msg?: string = "";
	content?: string = "";
	hot?: boolean = false;
	imageSize?: string = "";
	imageUrl?: string = "";
	jokesId?: number = 0;
	latitudeLongitude?: string = "";
	showAddress?: string = "";
	thumbUrl?: string = "";
	type?: number = 0;
	userId?: number = 0;
	videoSize?: string = "";
	videoTime?: number = 0;
	videoUrl?: string = "";
}
export class FreshPageDataUser {
	avatar?: string = "";
	nickName?: string = "";
	signature?: string = "";
	userId?: number = 0;
}
export class FreshPageData {
	info?: FreshPageDataInfo = new FreshPageDataInfo();
	joke?: FreshPageDataJoke = new FreshPageDataJoke();
	user?: FreshPageDataUser = new FreshPageDataUser();
}
