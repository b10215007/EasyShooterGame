//
//  ValidUtil.swift
//  KingOfSoccerShooter
//
//  Created by michael on 2018/8/1.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit


class ValidateUtil {

  static let shared = ValidateUtil()

  func hexStringToUIColor(hex: String) -> UIColor{
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
      cString.remove(at: cString.startIndex)
    }
    //預設顏色
    if cString.count < 6 {
      return UIColor.white
    }

    var rgbValue: UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
      blue: CGFloat((rgbValue & 0x0000FF)) / 255,
      alpha: 1)
  }

  func isValidEmail(withEmail email: String) -> Bool{
    let emailRegularExpression = "[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
    let emailNSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegularExpression)
    return emailNSPredicate.evaluate(with: email)
  }

  func isValidPhoneNumber(withNumber phone: String) -> Bool {
    let phoneRegularExpression = "^[0-9]{10}"
    let phoneNSPredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegularExpression)
    return phoneNSPredicate.evaluate(with: phone)
  }

  func isNumber(withNumber number: String) -> Bool {
    return !number.isEmpty && number.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
  }

  func isValidDate(withFormat strFormat: String, strDate date:  String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = strFormat
    if let _ = dateFormatter.date(from: date) {
      return true //valid format
    }else{
      return false
    }
  }


}
