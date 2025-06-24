import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { IBestInit } from "@ibestservices/ibest-ui"

const DOMAIN = 0x0000;

interface Params {
  targetIndex: number | null
}

export default class EntryAbility extends UIAbility {
  // 通过卡片跳转的index
  private navIndex: number|null = null


  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    console.log("want",JSON.stringify(want,null,2))
    const param = want.parameters?.params as string
    if (param) {
      console.log("++++param+++",JSON.stringify(param,null,2))
      this.navIndex = (JSON.parse(param) as Params).targetIndex
    }

    // 先判断有没有,有的话就直接传数字
    if (this.navIndex || this.navIndex===0) {
      console.log("++++navIndex+++",JSON.stringify(this.navIndex,null,2))
      AppStorage.setOrCreate('targetNavIndex', this.navIndex)
    }

    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    const param = want.parameters?.params as string
    if (param) {
      console.log("++++param+++",JSON.stringify(param,null,2))
      this.navIndex = (JSON.parse(param) as Params).targetIndex
    } else {
      return
    }
    // 先判断有没有,有的话就直接传数字
    if (this.navIndex || this.navIndex===0) {
      // delete want.parameters!.params.targetIndex
      console.log("++++navIndex+++",JSON.stringify(this.navIndex,null,2))
      AppStorage.setOrCreate('targetNavIndex', this.navIndex)
      const nav = AppStorage.get('navPathStackLocal') as NavPathStack
      nav.popToName('Index')
    }
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    // 存储环境变量的全局状态 (从上至下优先级一次增高)
    // Environment.envProp("BASE_URL", 'https://www.baidu.com')
    //
    // Environment.envProp("PROJECT_TOKEN", '8C2E963BDEFD4B828B58FF1A1F1E9DBA')
    //
    // PersistentStorage.persistProp('key', 'value')
    //
    // AppStorage.setOrCreate('key', 'value')

    windowStage.loadContent('App', (err) => {
      if (err.code) {
        console.error('Failed to load the content. Cause:' + JSON.stringify(err));
        return;
      }
      IBestInit(windowStage, this.context);
      // 持久化数据初始化 ，在这里持久化，然后在将来都是使用AppStorage进行操作
      // 持久化到磁盘
      PersistentStorage.persistProp('token', '');
      //用户个人信息
      PersistentStorage.persistProp('userInfo', {})
      
      console.info('Succeeded in loading the content.');
    });

  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');

  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}