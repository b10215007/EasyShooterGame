//
//  String + Util.swift
//  KingOfSoccerShooter
//
//  Created by michael on 2018/8/1.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

extension String {

  // 去空白字元
  func trim() -> String{
    return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }

  func subString(from: Int) -> String {
    guard from >= 0 && from <= self.count + 1 else{return ""}
    let fromIndex = self.index(self.startIndex, offsetBy: from)
    return String(self[fromIndex...])
  }

  func subString(to: Int) -> String {
    guard to >= 0 && to <= self.count else{return ""}
    let toIndex = self.index(self.startIndex, offsetBy: to)
    return String(self[..<toIndex])
  }

  func subString(from: Int, to: Int) -> String {
    guard from >= 0 && from < self.count else{return ""}
    let range: Range = self.index(self.startIndex, offsetBy: from <= self.count ? from:self.count) ..< self.index(self.startIndex, offsetBy: to <= self.count ? to:self.count)
    return String(self[range])
  }

  func split(separator: Character) -> [String] {
    return self.split{ $0 == separator }.map(String.init)
  }
}
