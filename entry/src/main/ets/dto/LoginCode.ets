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