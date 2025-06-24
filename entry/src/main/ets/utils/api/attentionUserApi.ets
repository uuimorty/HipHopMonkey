import { request } from "../request";


export class attentionUserParams {
  userId: string
  status: string

  constructor(userId: string, status: string) {
    this.userId = userId;
    this.status = status;
  }
}

export function attentionUserApi(config: attentionUserParams) {
  return request.post('/user/attention', null, {
    params: {
      userId: config.userId,
      status: config.status
    }
  })
}
