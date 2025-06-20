import { AppointUser, AppointUserData, User, UserData } from '../dto/User'
import { request } from '../utils/request'
import { AxiosResponse } from '@ohos/axios'


export default class UserModel {
  userData: UserData = {}
  appointUserData: AppointUserData = {}

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
  async getAppointUser() {
    const res: AxiosResponse<AppointUser> = await request.post("/user/info/target")
    if (res.data.data) {
      this.appointUserData = res.data.data
    }
  }
}