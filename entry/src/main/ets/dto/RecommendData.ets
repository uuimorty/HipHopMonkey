@Observed
export class RecommendData {
  code?: number = 0;
  @Track data?: RecommendDataItem[] = [];
  msg?: string = "";
}

export class RecommendDataDataInfo {
  @Track commentNum?: number = 0;
  @Track disLikeNum?: number = 0;
  @Track isAttention?: boolean = false;
  @Track isLike?: boolean = false;
  @Track isUnlike?: boolean = false;
  @Track likeNum?: number = 0;
  @Track shareNum?: number = 0;
}

export class RecommendDataDataJoke {
  @Track addTime?: string = "";
  @Track audit_msg?: string = "";
  @Track content?: string = "";
  @Track hot?: boolean = false;
  @Track imageSize?: string = "";
  @Track imageUrl?: string = "";
  @Track jokesId?: number = 0;
  @Track latitudeLongitude?: string = "";
  @Track showAddress?: string = "";
  @Track thumbUrl?: string = "";
  @Track type?: number = 0;
  @Track userId?: number = 0;
  @Track videoSize?: string = "";
  @Track videoTime?: number = 0;
  @Track videoUrl?: string = "";
}

export class RecommendDataDataUser {
  @Track avatar?: string = "";
  @Track nickName?: string = "";
  @Track signature?: string = "";
  @Track userId?: number = 0;
}

@Observed
export class RecommendDataItem {
  @Track info?: RecommendDataDataInfo = new RecommendDataDataInfo();
  @Track joke?: RecommendDataDataJoke = new RecommendDataDataJoke();
  @Track user?: RecommendDataDataUser = new RecommendDataDataUser();
}