@ObservedV2
export class AttentionUser {
  code?: number = 0;
  @Trace data?: AttentionUserData = new AttentionUserData();
  msg?: string = "";
}

@ObservedV2
export class AttentionUserData {
  @Trace "attentionState": number;
}