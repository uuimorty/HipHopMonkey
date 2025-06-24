import { preferences, ValueType } from "@kit.ArkData";

const FORM_ID = "FORM_ID"
/**
 * 初始化卡片
 */
export class PreferencesUtil {
  static preference: preferences.Preferences;

  static init(context: Context) {
    if (PreferencesUtil.preference) {
      return
    }
    console.log('初始化首选项')
    PreferencesUtil.preference = preferences.getPreferencesSync(context, { name: FORM_ID })
    console.log('首选项', JSON.stringify(PreferencesUtil.preference))
  }

  static set(key: string, value: ValueType) {
    if (!PreferencesUtil.preference) {
      return console.error("preference没有初始化-set")
    }
    console.log("key:value", key, value)
    PreferencesUtil.preference.putSync(key, value)
    PreferencesUtil.preference.flushSync()
  }

  static get<T extends preferences.ValueType>(key: string, defaultValue: preferences.ValueType = ''): T {
    if (!PreferencesUtil.preference) {
      console.error("preference没有初始化-get")
      return defaultValue as T
    }
    return PreferencesUtil.preference.getSync(key, defaultValue) as T
  }
}