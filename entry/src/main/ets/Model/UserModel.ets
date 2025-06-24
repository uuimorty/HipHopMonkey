import { AppointUser, AppointUserData, User, UserConcerned, UserConcernedData, UserData } from '../dto/User'
import { request } from '../utils/request'
import { AxiosResponse } from '@ohos/axios'

interface Data { targetUserId: number }

export default class UserModel {
  userData: UserData = {}
  appointUserData: AppointUserData = {}
  concernedUserData: UserConcernedData[] = []

  //获取登录用户信息
  async getUserData() {
    const res: AxiosResponse<User> = await request.post("/user/info")
    if (res.data.data) {
      this.userData = res.data.data
      AppStorage.setOrCreate("AppStorage", this.userData)
    } else {
      console.log("用户无任何数据")
    }

  }

  //获取指定用户信息
  async getAppointUser(userId: number) {

    const data: [] = []
    const res: AxiosResponse<AppointUser> =
      await request.post("/user/info/target", data, { params: { targetUserId: userId } })
    if (res.data.data) {
      this.appointUserData = res.data.data
    } else {
      console.log("指定用户数据无", res.data.data)
    }
  }

  //获取指定用户作品信息

  //获取指定用户关注信息
  async getUserConcerned(targetUserId: number, page: number = 1) {
    console.log("指定用户关注信息", targetUserId)
    const data: [] = []
    const res: AxiosResponse<UserConcerned> =
      await request.post("/user/attention/list", data, { params: { targetUserId: targetUserId, page: page } })
    if (res.data.data) {
      this.concernedUserData = res.data.data
    } else {
      console.log("指定用户数据无", res.data.data)
    }
    console.log("我是关注数据", targetUserId, JSON.stringify(res, null, 2))

  }

  //取消或者关注用户
  async cancelOrConcernedUSer(userId: number, status: 0 | 1) {
    const data: [] = []
    request.post("/user/attention", data, { params: { userId: userId, status: status } })
  }
}