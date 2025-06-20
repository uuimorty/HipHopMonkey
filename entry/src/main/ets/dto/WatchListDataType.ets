@Observed
export class WatchListDataType {
  @Track code?: number = 0;
  @Track data?: WatchListDataTypeData[] = [];
  @Track msg?: string = "";
}

@Observed
export class WatchListDataTypeData {
  @Track avatar?: string = "";
  @Track fansNum?: string = "";
  @Track isAttention?: boolean = false;
  @Track jokesNum?: string = "";
  @Track nickname?: string = "";
  @Track userId?: number = 0;
}