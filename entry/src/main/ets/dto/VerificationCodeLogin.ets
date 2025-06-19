export class codeLoginData {
  code?: number = 0;
  data?: UserTokenData = new UserTokenData();
  msg?: string = "";
}

export class UserTokenDataUserInfo {
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

export class UserTokenData {
  token?: string = "";
  type?: string = "";
  userInfo?: UserTokenDataUserInfo = new UserTokenDataUserInfo();
}