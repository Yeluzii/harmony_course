import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';

const TAG: string = 'CountProvider';
const DOMAIN: number = 0x0005;

/**
 * 计数器数据提供者
 * 提供计数器相关操作和数据同步功能
 */
class CountProvider {
  private static instance: CountProvider | null = null;
  private count: number = 0;
  private listeners: Array<() => void> = [];

  // 私有构造函数，实现单例模式
  private constructor() {
  }

  /**
   * 获取CountProvider单例实例
   */
  static getInstance(): CountProvider {
    if (!CountProvider.instance) {
      CountProvider.instance = new CountProvider();
    }
    return CountProvider.instance;
  }

  /**
   * 初始化计数器数据
   */
  async init(): Promise<void> {
    try {
      // 从AppStorage读取计数器值
      const storedCount = AppStorage.get<number>('counter_value');
      if (storedCount !== undefined) {
        this.count = storedCount;
      } else {
        // 如果AppStorage中没有值，则初始化为0
        this.count = 0;
      }
      hilog.info(DOMAIN, TAG, `计数器 provider 初始化完成，当前值: ${this.count}`);
    } catch (error) {
      const businessError = error as BusinessError;
      hilog.error(DOMAIN, TAG, `初始化计数器失败: ${businessError.message}`);
    }
  }

  // // 更新数值
  //  updateCounter(count: number): void {
  //   this.count = count
  //   AppStorage.set<number>('counter_value', count);
  // }

  /**
   * 获取当前计数
   */
  getCount(): number {
    return this.count;
  }

  /**
   * 增加计数
   */
  async increment(): Promise<void> {
    console.log(`${this.count} + 1`)
    this.count++;
    await this.saveCount();
  }

  /**
   * 减少计数
   */
  async decrement(): Promise<void> {
    if (this.count > 0) {
      this.count--;
      await this.saveCount();
    }
  }

  /**
   * 重置计数
   */
  async reset(): Promise<void> {
    this.count = 0;
    await this.saveCount();
  }

  /**
   * 保存计数到本地存储
   */
  private async saveCount(): Promise<void> {
    try {
      AppStorage.set<number>('counter_value', this.count);
      // hilog.info(DOMAIN, TAG, `计数器保存成功，当前值: ${this.count}`);
    } catch (error) {
      const businessError = error as BusinessError;
      hilog.error(DOMAIN, TAG, `保存计数器失败: ${businessError.message}`);
    }
  }
}

// 导出单例
export { CountProvider };