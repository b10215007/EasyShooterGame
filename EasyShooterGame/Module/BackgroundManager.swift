//
//  BackgroundManager.swift
//  KingOfSoccerShooter
//
//  Created by michael on 2018/7/29.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit


class BackgroundManager {

  private static var singleton: BackgroundManager?
  static func shared() -> BackgroundManager? {
    if singleton == nil {
      singleton = BackgroundManager()
    }
    return singleton
  }

  var image: UIImage = #imageLiteral(resourceName: "BG1") {
    didSet{
      saveBackground(image: image)
    }
  }

  func configuareBackground(){
    if let value = UserInfoManager.get(key: UserInfoKey.backgroundType) as? Int{
      image = UIImage(named: "BG\(value)")!
    }
  }

  private func saveBackground(image: UIImage){
    switch image {
    case #imageLiteral(resourceName: "BG1"):
      UserInfoManager.set(value: 1, key: UserInfoKey.backgroundType)
    case #imageLiteral(resourceName: "BG2"):
      UserInfoManager.set(value: 2, key: UserInfoKey.backgroundType)
    default:
      UserInfoManager.set(value: 3, key: UserInfoKey.backgroundType)
    }
  }


}
