import UserModel from '../Model/UserModel'
import { AppointUserData, UserData } from '../dto/User'

@Observed
export default class UserViewModel {
  @Track userData: UserData = {}
  @Track appointUserData: AppointUserData = {}
  @Track loading: boolean = true
  userModel = new UserModel()

  async getUserData() {
    try {
      // const
      await this.userModel.getUserData()
      this.loading = false
      this.userData = this.userModel.userData
    } catch (e) {
      console.log("获取用户数据视图模块层出错", e)
    }
  }

  async getAppointUser() {
    try {
      await this.userModel.getAppointUser()
      this.loading = false
      this.appointUserData = this.userModel.appointUserData

    } catch (e) {
      console.log("获取指定用户数据视图模块层出错");
    }

  }
}