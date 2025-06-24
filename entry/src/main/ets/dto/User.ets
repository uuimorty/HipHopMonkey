export class User {
  code?: number = 0;
  data?: UserData = new UserData();
  msg?: string = "";
}

export class UserDataInfo {
  attentionNum?: number = 0;
  experienceNum?: number = 0;
  fansNum?: number = 0;
  likeNum?: number = 0;
}

export class UserDataUser {
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

export class UserData {
  info?: UserDataInfo = new UserDataInfo();
  user?: UserDataUser = new UserDataUser();
}

//指定用户
export class AppointUser {
  data?: AppointUserData = new AppointUserData();
  msg?: string = "";
  code?: number = 0;
}

export class AppointUserData {
  userId?: number = 0;
  avatar?: string = "";
  cover?: string = "";
  nickname?: string = "";
  sigbature?: string = "";
  joinTime?: string = "";
  likeNum?: string = "";
  jokeLikeNum?: string = "";
  commentNum?: string = "";
  collectNum?: string = "";
  jokesNum?: string = "";
  attentionNum?: string = "";
  fansNum?: string = "";
  attentionState?: number = 0;
}

//获取指定用户的关注信息
export class UserConcerned {
  data?: UserConcernedData[] = [];
  msg?: string = "";
  code?: number = 0;
}

export class UserConcernedData {
  userId?: number = 0;
  nickname?: string = "";
  avatar?: string = "";
  signature?: string = "";
  attention?: number = 0;
}

//获取指定用户的粉丝信息
export class UserFans {
  data?: UserFansData[] = [];
  msg?: string = "";
  code?: number = 0;
}

export class UserFansData {
  userId?: number = 0;
  nickname?: string = "";
  avatar?: string = "";
  signature?: string = "";
  attention?: number = 0;
}

