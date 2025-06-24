import UserModel from '../Model/UserModel'
import { AppointUserData, UserConcernedData, UserData } from '../dto/User'

@Observed
export default class UserViewModel {
  @Track userData: UserData = {}
  @Track appointUserData: AppointUserData = {}
  @Track loading: boolean = true
  @Track concernedUserData: UserConcernedData[] = []
  userModel = new UserModel()

  cancelConcernedUSer(index: number, status: 0 | 1, userId: number = 0) {
    if (!status) {
      this.concernedUserData.splice(index, 1)
      this.concernedUserData = [...this.concernedUserData]

    } else {

    }
    this.userModel.cancelOrConcernedUSer(userId, status)
  }

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

  async getAppointUser(userId: number) {
    try {
      await this.userModel.getAppointUser(userId)
      this.loading = false
      this.appointUserData = this.userModel.appointUserData

    } catch (e) {
      console.log("获取指定用户数据视图模块层出错");
    }
  }

  async getUserConcerned(targetUserId: number) {
    try {
      await this.userModel.getUserConcerned(targetUserId)
      this.loading = false
      this.concernedUserData = this.userModel.concernedUserData

    } catch (e) {
      console.log("获取指定用户关注数据出错")
    }
  }
}