//
//  FunctionViewController.swift
//  KingOfSoccerShooter
//
//  Created by michael on 2018/8/2.
//  Copyright © 2018年 michael. All rights reserved.
//

import UIKit

class FunctionViewController: UIViewController {

  let bgImage = UIImageView()
  let centerView = UIView()

  let soundEffectLabel = UILabel()
  let soundSwitch = UISwitch()

  let musicEffectLabel = UILabel()
  let musicSwitch = UISwitch()

  let bgMusicChoosedLabel = UILabel()
  var bgmCollectionView: UICollectionView!

  let backBtn = UIButton()

  let textArray = ["背景音乐选择", "音效", "背景音乐", "Back To Home"]
  let soundManager = SoundManager.shared()
  let colorManager = ColorManager.shared()
  var musicBtnArray:[UIButton] = []
  
  var font = UIFont.systemFont(ofSize: 24, weight: .semibold)
  var topGap = CGFloat(24)
  var topMargin = CGFloat(16)


  var seleectedColorItemIndex = UserInfoManager.get(key: UserInfoKey.backgroundType) as? Int ?? 1{
    didSet{
      UserInfoManager.set(value: seleectedColorItemIndex, key: UserInfoKey.backgroundType)
    }
  }
  var viewPushedByGame = false

  override func viewDidLoad() {
    super.viewDidLoad()

    if screenHeight < 500 {
      font = UIFont.systemFont(ofSize: 18, weight: .semibold)
      topGap = CGFloat(16)
      topMargin = CGFloat(5)
    }

    initView()
    initSettingView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func initView(){
    initBackground()
    initCenterView()
    initBGMChoosedView()
    initSoundEffectView()
    initMsuicEffectView()
    initBackBtn()
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
    centerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(centerView)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
    if screenHeight > 500 {
      constraints.append(NSLayoutConstraint(item: centerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 560))}
    else {
      constraints.append(NSLayoutConstraint(item: centerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 400))
    }
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: centerView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))

    NSLayoutConstraint.activate(constraints)
  }

  func initBGMChoosedView(){
    bgMusicChoosedLabel.text = textArray[0]
    bgMusicChoosedLabel.textColor = UIColor.black
    bgMusicChoosedLabel.font = font
    centerView.addSubview(bgMusicChoosedLabel)
    bgMusicChoosedLabel.translatesAutoresizingMaskIntoConstraints = false

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: bgMusicChoosedLabel, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: bgMusicChoosedLabel, attribute: .centerY, relatedBy: .equal, toItem: centerView, attribute: .centerY, multiplier: 0.32, constant: 0))

    let layout = UICollectionViewFlowLayout()
    if screenWidth < 375 {
      layout.minimumLineSpacing = 24
    }else{
      layout.minimumLineSpacing = 40
    }
    layout.scrollDirection = .horizontal

    bgmCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
    bgmCollectionView.register(FunctionCollectionViewCell.self, forCellWithReuseIdentifier: FunctionCollectionViewCell.identifier)

    bgmCollectionView.delegate = self
    bgmCollectionView.dataSource = self
    bgmCollectionView.backgroundColor = UIColor.clear
    bgmCollectionView.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(bgmCollectionView)

    constraints.append(NSLayoutConstraint(item: bgmCollectionView, attribute: .top, relatedBy: .equal, toItem: bgMusicChoosedLabel, attribute: .bottom, multiplier: 1, constant: topMargin))
    constraints.append(NSLayoutConstraint(item: bgmCollectionView, attribute: .centerX, relatedBy: .equal, toItem: bgMusicChoosedLabel, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: bgmCollectionView, attribute: .width, relatedBy: .equal, toItem: centerView, attribute: .width, multiplier: 0.64, constant: 0))
    constraints.append(NSLayoutConstraint(item: bgmCollectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 56))

    NSLayoutConstraint.activate(constraints)
  }


  func initSoundEffectView(){
    soundEffectLabel.text = textArray[1]
    soundEffectLabel.textColor = UIColor.black
    soundEffectLabel.font = font
    soundEffectLabel.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(soundEffectLabel)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: soundEffectLabel, attribute: .top, relatedBy: .equal, toItem: bgmCollectionView, attribute: .bottom, multiplier: 1, constant: topGap))
    constraints.append(NSLayoutConstraint(item: soundEffectLabel, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0))

    soundSwitch.backgroundColor = UIColor.clear
    soundSwitch.addTarget(self, action: #selector(switchAction(_:)), for: .valueChanged)
    soundSwitch.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(soundSwitch)

    constraints.append(NSLayoutConstraint(item: soundSwitch, attribute: .centerX, relatedBy: .equal, toItem: soundEffectLabel, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: soundSwitch, attribute: .top, relatedBy: .equal, toItem: soundEffectLabel, attribute: .bottom, multiplier: 1, constant: topMargin))
    constraints.append(NSLayoutConstraint(item: soundSwitch, attribute: .height, relatedBy: .equal, toItem: centerView, attribute: .height, multiplier: 0.1, constant: 0))
    NSLayoutConstraint.activate(constraints)
  }

  func initMsuicEffectView(){
    musicEffectLabel.text = textArray[2]
    musicEffectLabel.textColor = UIColor.black
    musicEffectLabel.font = font
    musicEffectLabel.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(musicEffectLabel)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: musicEffectLabel, attribute: .top, relatedBy: .equal, toItem: soundSwitch, attribute: .bottom, multiplier: 1, constant: topGap))
    constraints.append(NSLayoutConstraint(item: musicEffectLabel, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0))

    musicSwitch.backgroundColor = UIColor.clear
    musicSwitch.addTarget(self, action: #selector(switchAction(_:)), for: .valueChanged)
    musicSwitch.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(musicSwitch)

    constraints.append(NSLayoutConstraint(item: musicSwitch, attribute: .centerX, relatedBy: .equal, toItem: soundEffectLabel, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: musicSwitch, attribute: .top, relatedBy: .equal, toItem: musicEffectLabel, attribute: .bottom, multiplier: 1, constant: topMargin))
    constraints.append(NSLayoutConstraint(item: musicSwitch, attribute: .height, relatedBy: .equal, toItem: soundSwitch, attribute: .height, multiplier: 1, constant: 0))


    NSLayoutConstraint.activate(constraints)
  }

  func initBackBtn(){
    backBtn.titleLabel?.font = font
    backBtn.setTitleColor(UIColor.white, for: .normal)
    backBtn.setTitle(textArray[3], for: .normal)
    backBtn.setBackgroundImage(#imageLiteral(resourceName: "button_green"), for: .normal)
    backBtn.addTarget(self, action: #selector(backHomeBtnAction(_:)), for: UIControlEvents.touchUpInside)
    backBtn.translatesAutoresizingMaskIntoConstraints = false
    centerView.addSubview(backBtn)

    var constraints = [NSLayoutConstraint]()
    constraints.append(NSLayoutConstraint(item: backBtn, attribute: .centerX, relatedBy: .equal, toItem: centerView, attribute: .centerX, multiplier: 1, constant: 0))
    constraints.append(NSLayoutConstraint(item: backBtn, attribute: .bottom, relatedBy: .equal, toItem: centerView, attribute: .bottom, multiplier: 1, constant: -8))
    constraints.append(NSLayoutConstraint(item: backBtn, attribute: .width, relatedBy: .equal, toItem: centerView, attribute: .width, multiplier: 0.72, constant: 0))
    constraints.append(NSLayoutConstraint(item: backBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 56))

    NSLayoutConstraint.activate(constraints)
  }


  func initSettingView(){

    if let value = UserDefaults.standard.value(forKey: "musicIsOn") as? Bool {
      musicSwitch.isOn = value ? true:false
    }

    if let value = UserDefaults.standard.value(forKey: "soundIsOn") as? Bool {
      soundSwitch.isOn = value ? true:false
    }
  }

  @objc func switchAction(_ sender: UISwitch) {
    if(sender == soundSwitch) {
      UserInfoManager.set(value: sender.isOn, key: UserInfoKey.soundIsOn)
    }else{
      UserInfoManager.set(value: sender.isOn, key: UserInfoKey.musicIsOn)
    }
  }

  @objc func backHomeBtnAction(_ sender: UIButton) {
    if viewPushedByGame{
      viewPushedByGame = false
      self.navigationController?.popViewController(animated: false)
    }else{
      self.navigationController?.popToRootViewController(animated: false)
    }
  }

}

extension FunctionViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 52, height: 52)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FunctionCollectionViewCell.identifier, for: indexPath) as! FunctionCollectionViewCell
    let index = indexPath.row
    
    cell.textLabel.textColor = colorManager?.mainColor
    cell.textLabel.text = "\(index + 1)"
    cell.textLabel.font = font
    cell.imageView.image = UIImage(named: "none")

    let value = UserInfoManager.get(key: UserInfoKey.musicType) as? Int ?? 1
    if indexPath.row == value{
      cell.imageView.image = #imageLiteral(resourceName: "circle_green")
    }

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    soundManager.backgroundMusicType = indexPath.row
    UserInfoManager.set(value: indexPath.row, key: UserInfoKey.musicType)
    soundManager.backgroundMusicHandler()
    collectionView.reloadData()

  }

}
