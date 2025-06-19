export class RecommendData {
  code?: number = 0;
  data?: RecommendDataItem[] = [];
  msg?: string = "";
}

export class RecommendDataDataInfo {
  commentNum?: number = 0;
  disLikeNum?: number = 0;
  isAttention?: boolean = false;
  isLike?: boolean = false;
  isUnlike?: boolean = false;
  likeNum?: number = 0;
  shareNum?: number = 0;
}

export class RecommendDataDataJoke {
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

export class RecommendDataDataUser {
  avatar?: string = "";
  nickName?: string = "";
  signature?: string = "";
  userId?: number = 0;
}

export class RecommendDataItem {
  info?: RecommendDataDataInfo = new RecommendDataDataInfo();
  joke?: RecommendDataDataJoke = new RecommendDataDataJoke();
  user?: RecommendDataDataUser = new RecommendDataDataUser();
}