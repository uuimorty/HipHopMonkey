export class LoginCode {
	code?: number = 0;
	data?: LoginCodeData = new LoginCodeData();
	msg?: string = "";
}
export class LoginCodeDataUserInfo {
	avatar?: string = "";
	birthday?: string = "";
	inviteCode?: string = "";
	invitedCode?: string = "";
	nickname?: string = "";
	sex?: string = "";
	signature?: string = "";
	userId?: number = 0;
	userPhone?: string = "";
}
export class LoginCodeData {
	token?: string = "";
	type?: string = "";
	userInfo?: LoginCodeDataUserInfo = new LoginCodeDataUserInfo();
}


export class LoginResp {
	code?: number = 0;
	data?: LoginRespData = new LoginRespData();
	msg?: string = "";
}
export class LoginRespDataUserInfo {
	avatar?: string = "";
	birthday?: string = "";
	inviteCode?: string = "";
	invitedCode?: string = "";
	nickname?: string = "";
	sex?: string = "";
	signature?: string = "";
	userId?: number = 0;
	userPhone?: string = "";
}
export class LoginRespData {
	token?: string = "";
	type?: string = "";
	userInfo?: LoginRespDataUserInfo = new LoginRespDataUserInfo();
}