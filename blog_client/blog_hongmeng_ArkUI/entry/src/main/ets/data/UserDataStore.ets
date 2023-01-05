/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
import dataStorage from '@ohos.data.storage';
import featureAbility from '@ohos.ability.featureAbility';

let STORAGE_FILE = "user_file";

export class User {
  private static sInstance: User = new User();

  public static get(): User {
    return User.sInstance;
  }

  private constructor() {
    this.init();
  }

  private token: string = '';

  public getToken() {
    return this.token
  }

  public setToken(token: string) {
    this.token = token
  }

  public toString() {
    return JSON.stringify(User.get());
  }

  // 初始化用户数据
  public init() {
    featureAbility.getContext().getFilesDir((error, path) => {
      if (path) {
        var storage = dataStorage.getStorageSync(path + "/" + STORAGE_FILE);
        if (storage) {
          var value = storage.getSync("token", "").toString();
          if (value.length > 0) {
            this.setToken(value)
          }
        } else {
          //          Logger.log("get storage invalid")
        }
      }
    });
  }

  // 保存用户数据
  public save() {
    featureAbility.getContext().getFilesDir((error, path) => {
      if (path) {
        var storage = dataStorage.getStorageSync(path + "/" + STORAGE_FILE);
        if (storage) {
          storage.putSync("token", this.getToken());
          storage.flushSync();
        } else {
          //          Logger.log("get storage invalid")
        }
      }
    });
  }

  // 清空缓存数据
  public clear() {
    User.sInstance = new User();
    featureAbility.getContext().getFilesDir((error, path) => {
      if (path) {
        var storage = dataStorage.getStorageSync(path + "/" + STORAGE_FILE);
        if (storage) {
          storage.clearSync();
        } else {
          //          Logger.log("get storage invalid")
        }
      }
    });
  }
}