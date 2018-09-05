//
//  UserDefaults.swift
//  soccorConnectGame
//
//  Created by michael on 2018/7/15.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class UserInfoManager: NSObject {
  static func set(value : Any, key : UserInfoKey) {

    UserDefaults.standard.set(value, forKey: key.rawValue)
    UserDefaults.standard.synchronize()
  }

  static func get(key : UserInfoKey) -> Any? {
    return UserDefaults.standard.value(forKey: key.rawValue)
  }

  static func setArray(array: [Any], key : UserInfoKey) {
    UserDefaults.standard.set(array, forKey: key.rawValue)
    UserDefaults.standard.synchronize()
  }

  static func getArray(key : UserInfoKey) -> [Any]? {
    return UserDefaults.standard.array(forKey: key.rawValue)
  }
}

enum UserInfoKey : String {
  case soundIsOn =  "soundIsOn"
  case musicIsOn = "musicIsOn"
  case musicType = "musicType"
  case easyRecord = "easyRecord"
  case normalRecord = "normalRecord"
  case hardRecord = "hardRecord"
  case backgroundType = "backgroundType"
  case isIntroOn = "isIntroOn"
}

