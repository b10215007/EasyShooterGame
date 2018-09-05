//
//  DateUtil.swift
//  KingOfSoccerShooter
//
//  Created by michael on 2018/8/1.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class DateUtil: NSObject {

  static let shared = DateUtil()

  func getSysDate(withFormat strFormat: String) -> String{
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.dateFormat = strFormat
    dateFormatter.timeZone = TimeZone.ReferenceType.system
    return dateFormatter.string(from: Date())
  }

  func getDateFromString(withFormat strFormat: String, strDate: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = strFormat
    dateFormatter.timeZone = TimeZone.ReferenceType.system
    return dateFormatter.date(from: strDate)!
  }

  func getStringFromDate(withFormat strFormat: String, date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = strFormat
    dateFormatter.timeZone = TimeZone.ReferenceType.system
    return dateFormatter.string(from: date)
  }

  func addDayAfterDate(withSecond second: Double, date: Date) -> Date {
    return date.addingTimeInterval(second)
  }

  func getDayOfWeek(withDate date: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    dateFormatter.timeZone = TimeZone.ReferenceType.system
    if let todayDate = dateFormatter.date(from: date) {
      let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
      let weekDay = calendar.component(.weekday, from: todayDate)
      switch weekDay {
      case 1:
        return "日"
      case 2:
        return "一"
      case 3:
        return "二"
      case 4:
        return "三"
      case 5:
        return "四"
      case 6:
        return "五"
      case 7:
        return "六"
      default:
        print("Error")
        return "Nil"
      }
    }else{
      return nil
    }
  }
}
