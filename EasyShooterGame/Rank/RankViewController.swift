//
//  IntroduceViewController.swift
//  soccorConnectGame
//
//  Created by michael on 2018/7/15.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit
import CoreData

class RankViewController: UIViewController {

  let centerView: UIView = UIView()
  let stackView: UIStackView = UIStackView()
  let easyBtn: UIButton = UIButton()
  let normalBtn: UIButton = UIButton()
  let hardBtn: UIButton = UIButton()
  let hintImage: UIImageView = UIImageView()
  var shapeLayer = CAShapeLayer()
  let backBtn: UIButton = UIButton()

  let tableView: UITableView = UITableView()
  let bgImage: UIImageView = UIImageView()
  let infoBg: UIImageView = UIImageView()

  var btnArray:[UIButton] = []
  let btnTitleArray = ["Easy", "Normal", "Hard", "Back To Home"]
  let btnBackground = [#imageLiteral(resourceName: "rectangle_orange"),#imageLiteral(resourceName: "rectangle_pink"),#imageLiteral(resourceName: "rectangle_red")]
  let btnColor = [
    UIColor(red: 244/255, green: 169/255, blue: 33/255, alpha: 1),
    UIColor(red: 255/255, green: 142/255, blue: 142/255, alpha: 1),
    UIColor(red: 223/255, green: 20/255, blue: 20/255, alpha: 1)]

  var centerViewHeight = CGFloat(420)

  var modeChoosed = GameMode.Easy
  var scoreRecordRankList = [[String:String]]()
  var scoreArray = [Int]()

  let colorManager = ColorManager.shared()

  override func viewDidLoad() {
    super.viewDidLoad()

    if screenHeight < 500 {
      centerViewHeight = 320
    }

    initView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func initView(){
    initBackground()
    initCenterView()
    initModeBtn()
    initBtnStack()
    initTableView()
    initBackBtn()
  }


  override func viewDidAppear(_ animated: Bool) {
    drawTriangle(rect: easyBtn.frame, color: btnColor[0])
  }

  func initBackground(){
    bgImage.translatesAutoresizingMaskIntoConstraints = false //一定要加
    bgImage.image = #imageLiteral(resourceName: "bg")

    view.addSubview(bgImage)
    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: bgImage, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: bgImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: bgImage, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: bgImage, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0))
    NSLayoutConstraint.activate(constraints)
  }

  func initCenterView(){
    centerView.backgroundColor = UIColor.clear
    view.addSubview(centerView)
    centerView.translatesAutoresizingMaskIntoConstraints = false
    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.88, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: centerViewHeight))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
    NSLayoutConstraint.activate(constraints)

    infoBg.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(infoBg)
    constraints = []
    constraints.append(NSLayoutConstraint(item: infoBg, attribute: .top, relatedBy: .equal, toItem: centerView, attribute: .top, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: infoBg, attribute: .bottom, relatedBy: .equal, toItem: centerView, attribute: .bottom, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: infoBg, attribute: .trailing, relatedBy: .equal, toItem: centerView, attribute: .trailing, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: infoBg, attribute: .leading, relatedBy: .equal, toItem: centerView, attribute: .leading, multiplier: 1, constant: 0))
    NSLayoutConstraint.activate(constraints)
    infoBg.image = #imageLiteral(resourceName: "info_pink")
  }

  func initModeBtn(){
    btnArray = [easyBtn, normalBtn, hardBtn]
    for (i, btn) in btnArray.enumerated() {
      btn.setTitle(btnTitleArray[i], for: .normal)
      btn.setTitleColor(UIColor.white, for: .normal)
      btn.setBackgroundImage(btnBackground[i], for: .normal)
      btn.addTarget(self, action: #selector(btnAction(_:)), for: UIControlEvents.touchUpInside)
      btn.translatesAutoresizingMaskIntoConstraints = false
    }
  }

  func initBtnStack(){
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillProportionally

    let viewArray = [easyBtn, normalBtn, hardBtn]
    for (i,view) in viewArray.enumerated() {
      view.tag = i
      view.translatesAutoresizingMaskIntoConstraints = false
      stackView.addArrangedSubview(view)
    }
    stackView.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(stackView)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: stackView, attribute: .width, relatedBy: .equal, toItem: centerView, attribute: .width, multiplier: 0.86, constant: 0))
    constraints.append(NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: centerView, attribute: .height, multiplier: 0.1, constant: 0))
    constraints.append(NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: centerView, attribute: .top, multiplier: 1, constant: 24))
    constraints.append(NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0))
    NSLayoutConstraint.activate(constraints)
  }

  func drawTriangle(rect: CGRect, color: UIColor){
    shapeLayer.removeFromSuperlayer()
    let x = rect.origin.x + 24
    let y = rect.origin.y + rect.height + 22
    let width = rect.width
    let path = UIBezierPath()
    path.move(to: CGPoint(x: x + width * 2 / 5, y: y))
    path.addLine(to: CGPoint(x: x + width / 2, y: y + width / 4))
    path.addLine(to: CGPoint(x: x + width * 3 / 5, y: y))
    path.close()
    shapeLayer.path = path.cgPath
    shapeLayer.fillColor = color.cgColor

    self.centerView.layer.addSublayer(shapeLayer)
  }

  @objc func btnAction(_ sender: UIButton){
    drawTriangle(rect: sender.frame, color: btnColor[sender.tag])

    switch sender.titleLabel?.text {
    case "Easy":
      modeChoosed = .Easy
    case "Normal":
      modeChoosed = .Normal
    default:
      modeChoosed = .Hard
    }
    loadRecordArray()
    tableView.reloadData()
  }

  func initTableView(){
    loadRecordArray()
    tableView.dataSource = self

    tableView.register(RankTableViewCell.self, forCellReuseIdentifier: RankTableViewCell.identifier)
    tableView.separatorStyle = .none
    tableView.backgroundColor = UIColor.clear

    tableView.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(tableView)
    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: stackView, attribute: .bottom, multiplier: 1, constant: 24))
    constraints.append(NSLayoutConstraint(item: tableView, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: tableView, attribute: .width, relatedBy: .equal, toItem: centerView, attribute: .width, multiplier: 0.8, constant: 0))
    constraints.append(NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: centerView, attribute: .height, multiplier: 0.56, constant: 0))
    NSLayoutConstraint.activate(constraints)
  }

  func initBackBtn(){
    backBtn.setTitle(btnTitleArray[3], for: .normal)
    backBtn.setTitleColor(UIColor.white, for: .normal)
    backBtn.setBackgroundImage(#imageLiteral(resourceName: "button_green"), for: .normal)
    backBtn.addTarget(self, action: #selector(backHomeAction(_:)), for: UIControlEvents.touchUpInside)

    backBtn.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(backBtn)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: backBtn, attribute: .top, relatedBy: .equal, toItem: centerView, attribute: .bottom, multiplier: 1, constant: 32))
    constraints.append(NSLayoutConstraint(item: backBtn, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: backBtn, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.64, constant: 0))
    constraints.append(NSLayoutConstraint(item: backBtn, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.08, constant: 0))
    NSLayoutConstraint.activate(constraints)
  }

  @objc func backHomeAction(_ sender: UIButton){
    self.navigationController?.popToRootViewController(animated: false)
  }

  func loadRecordArray(){
    switch modeChoosed {
    case .Easy:
      if let array = UserInfoManager.getArray(key: UserInfoKey.easyRecord) as? [Int] {
        scoreArray = array
      }else{
        scoreArray = []
      }
    case .Normal:
      if let array = UserInfoManager.getArray(key: UserInfoKey.normalRecord) as? [Int] {
        scoreArray = array
      }else{
        scoreArray = []
      }
    case .Hard:
      if let array = UserInfoManager.getArray(key: UserInfoKey.hardRecord) as? [Int] {
        scoreArray = array
      }else{
        scoreArray = []
      }
    }
  }

}

extension RankViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return scoreArray.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: RankTableViewCell.identifier, for: indexPath) as! RankTableViewCell
    cell.backgroundColor = UIColor.clear
    if indexPath.row == 0 {
      cell.numLabel.text = "Top 1"
    }else{
      cell.numLabel.text = "No. \(indexPath.row+1)"
    }
    cell.valueLabel.text = "\(scoreArray[indexPath.row])"

    return cell

  }

}
