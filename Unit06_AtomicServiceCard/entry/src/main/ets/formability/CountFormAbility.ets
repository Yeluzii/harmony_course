import { formBindingData, formInfo, formProvider, FormExtensionAbility } from '@kit.FormKit';
import type { Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { CountProvider } from '../providers/CountProvider';

const TAG: string = 'CountFormAbility';
const DOMAIN: number = 0x0001;
const COUNT_KEY: string = 'counter_value';

export interface FormData {
  method: string,
  counter_value: number
}

export default class CountFormAbility extends FormExtensionAbility {
  private countProvider: CountProvider = CountProvider.getInstance();

  onAddForm(want: Want): formBindingData.FormBindingData {
    hilog.info(DOMAIN,TAG,'进来了么/。。。。。。。。。')
    const formId: string = want.parameters?.['ohos.extra.param.key.form_identity'] as string;
    hilog.info(DOMAIN, TAG, "计数器卡片创建 " + `formId: ${formId}`)
    //
    // // 获取当前计数器值并传递给卡片
    // this.updateFormContent(formId);
    //
    // return formBindingData.createFormBindingData({});


    // 从 AppStorage 获取当前计数器值
    // let counterValue = AppStorage.get<number>('counter_value') || 0;
    let counterValue = this.countProvider.getCount()

    // 构建卡片显示的数据
    let formData: FormData = {
      method: '',
      counter_value: counterValue
    }

    // 更新卡片
    return formBindingData.createFormBindingData(formData)

  }

  onFormEvent(formId: string, message: string): void {
    hilog.info(DOMAIN, TAG, `收到消息: ${message}, formId: ${formId}`);
    let formData = JSON.parse(message) as FormData
    const action = formData.method
    if (action == 'increment') {
      hilog.info(DOMAIN, TAG, `加法事件：${formData.counter_value} + 1`)
      let newData: Record<string, Object> = {
        'counter_value': formData.counter_value + 1
      }
      formProvider.updateForm(formId, formBindingData.createFormBindingData(newData))
      this.countProvider.increment()
    } else if (action == 'decrement') {
      hilog.info(DOMAIN, TAG, `减法事件：${formData.counter_value} - 1`)
      if (formData.counter_value > 0) {
        let newData: Record<string, Object> = {
          'counter_value': formData.counter_value - 1
        }
        formProvider.updateForm(formId, formBindingData.createFormBindingData(newData))
        this.countProvider.decrement()
      }
    } else if (action == 'reset') {
      hilog.info(DOMAIN, TAG, `重置事件：${formData.counter_value} 已重置`)
      let newData: Record<string, Object> = {
        'counter_value': 0
      }
      formProvider.updateForm(formId, formBindingData.createFormBindingData(newData))
      this.countProvider.reset()
    }
  }

  onUpdateForm(formId: string) {
    const count = this.countProvider.getCount()
    let newData: Record<string, Object> = {
      'counter_value': count
    }
    formProvider.updateForm(formId, formBindingData.createFormBindingData(newData))
    hilog.info(DOMAIN, TAG, `卡片更新：count = ${count}`)
  }

  onRemoveForm(formId: string) {
    // 移除卡片
    hilog.info(DOMAIN, TAG, "计数器卡片删除: " + formId)
  }

  onAcquireFormState(want: Want) {
    // 获取卡片状态
    return formInfo.FormState.READY;
  }
};