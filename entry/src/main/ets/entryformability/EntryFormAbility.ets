import { formBindingData, FormExtensionAbility, formInfo, formProvider } from '@kit.FormKit';
import { Want } from '@kit.AbilityKit';
import { PreferencesUtil } from '../utils/PreferencesUtil';

export default class EntryFormAbility extends FormExtensionAbility {
  onAddForm(want: Want) {
    PreferencesUtil.init(this.context)
    // 为卡片提供初始化的数据
    console.log("want", JSON.stringify(want, null, 2))
    console.log("formId", want.parameters?.["ohos.extra.param.key.form_identity"])
    console.log("formName", want.parameters?.["ohos.extra.param.key.form_name"])
    const formName = want.parameters?.["ohos.extra.param.key.form_name"] as string
    const formId = want.parameters?.["ohos.extra.param.key.form_identity"] as string
    console.log(formName, formId)
    PreferencesUtil.set(formName, formId)

    return formBindingData.createFormBindingData({
      recommendTitle: '跳转到消息标题',
      recommendContent: '跳转到消息内容'
    });
  }

  onCastToNormalForm(formId: string) {
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
  }

  onUpdateForm(formId: string) {
    // Called to notify the form provider to update a specified form.
  }

  onFormEvent(formId: string, message: string) {
    // Called when a specified message event defined by the form provider is triggered.
    console.log("onFormEvent", formId, message)
    const data = formBindingData.createFormBindingData({
      title: '测试标题',
      content: '测试内容'
    })
    formProvider.updateForm(formId, data)

  }

  onRemoveForm(formId: string) {
    // Called to notify the form provider that a specified form has been destroyed.
  }

  onAcquireFormState(want: Want) {
    // Called to return a {@link FormState} object.
    return formInfo.FormState.READY;
  }
}