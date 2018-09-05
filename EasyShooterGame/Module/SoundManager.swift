//
//  soundManager.swift
//  iOSSwiftLab6
//
//  Created by michael on 2018/5/17.
//  Copyright © 2018年 Gates. All rights reserved.
//

import AVFoundation

class SoundManager {

  private static var singleton: SoundManager?

  static func shared() -> SoundManager {
    if singleton == nil{
      singleton = SoundManager()
    }
    return singleton!
  }

  enum SoundType: String {
    case hitSoundEffetct = "den"
    case celebrate = "celebrate"
    case gameOver = "gameOver"
    case wolf = "wolf"
    case score = "cashier"
  }

  enum MusicType: String {
    case BGM = "bgm"
    case BGM2 = "bgm2"
    case BGM3 = "bgm3"
  }

  struct bgmStruct {

    static private let backgroundMusicUrl = URL(fileURLWithPath:
      Bundle.main.path(forResource: MusicType.BGM.rawValue, ofType: "mp3")!)
    static private let backgroundMusicUrl2 = URL(fileURLWithPath:
      Bundle.main.path(forResource: MusicType.BGM2.rawValue, ofType: "mp3")!)
    static private let backgroundMusicUrl3 = URL(fileURLWithPath:
      Bundle.main.path(forResource: MusicType.BGM3.rawValue, ofType: "mp3")!)

    static var player = AVAudioPlayer()

    static func setBGM(index: Int) {
      switch index {
      case 0:
        player = try! AVAudioPlayer(contentsOf: backgroundMusicUrl)
      case 1:
        player = try! AVAudioPlayer(contentsOf: backgroundMusicUrl2)
      case 2:
        player = try! AVAudioPlayer(contentsOf: backgroundMusicUrl3)
      default:
        return
      }

      player.numberOfLoops = -1
      player.prepareToPlay()
    }
  }

  private var hitSoundEffectPlayer = AVAudioPlayer()
  private var gameOverSoundPlayer = AVAudioPlayer()
  private var celebrateSoundPlayer = AVAudioPlayer()
  private var scoreSoundPlayer = AVAudioPlayer()
  private var wolfSoundPlayer = AVAudioPlayer()

  var backgroundMusicType = 0{
    didSet{
      UserInfoManager.set(value: backgroundMusicType, key: UserInfoKey.musicType)
    }
  }
  var backgroundMusicState = true{
    didSet{
      UserInfoManager.set(value: backgroundMusicState, key: UserInfoKey.musicIsOn)
    }
  }
  var soundEffectState = true{
    didSet{
      UserInfoManager.set(value: soundEffectState, key: UserInfoKey.soundIsOn)
    }
  }


  func configureAllSound(){
    if let value = UserInfoManager.get(key: UserInfoKey.musicIsOn) as? Bool {
      backgroundMusicState = value
    }
    if let value = UserInfoManager.get(key: UserInfoKey.musicType) as? Int {
      backgroundMusicType = value
    }
    if let value = UserInfoManager.get(key: UserInfoKey.soundIsOn) as? Bool {
      soundEffectState = value
    }
    configureSound()
  }

  private func configureSound(){

    let hitSoundUrl = URL(fileURLWithPath:
      Bundle.main.path(forResource: SoundType.hitSoundEffetct.rawValue, ofType: "wav")!)
    let gameOverSoundUrl = URL(fileURLWithPath:
      Bundle.main.path(forResource: SoundType.gameOver.rawValue, ofType: "mp3")!)
    let celebrateSoundUrl = URL(fileURLWithPath:
      Bundle.main.path(forResource: SoundType.celebrate.rawValue, ofType: "mp3")!)
    let scoreSoundUrl = URL(fileURLWithPath:
      Bundle.main.path(forResource: SoundType.score.rawValue, ofType: "mp3")!)
    let wolfSoundUrl = URL(fileURLWithPath:
      Bundle.main.path(forResource: SoundType.wolf.rawValue, ofType: "mp3")!)

    hitSoundEffectPlayer = try! AVAudioPlayer(contentsOf: hitSoundUrl)
    hitSoundEffectPlayer.prepareToPlay()
    hitSoundEffectPlayer.numberOfLoops = 0

    gameOverSoundPlayer = try! AVAudioPlayer(contentsOf: gameOverSoundUrl)
    gameOverSoundPlayer.prepareToPlay()
    gameOverSoundPlayer.numberOfLoops = 0

    celebrateSoundPlayer = try! AVAudioPlayer(contentsOf: celebrateSoundUrl)
    celebrateSoundPlayer.prepareToPlay()
    celebrateSoundPlayer.numberOfLoops = 0

    scoreSoundPlayer = try! AVAudioPlayer(contentsOf: scoreSoundUrl)
    scoreSoundPlayer.prepareToPlay()
    scoreSoundPlayer.numberOfLoops = 0

    wolfSoundPlayer = try! AVAudioPlayer(contentsOf: wolfSoundUrl)
    wolfSoundPlayer.prepareToPlay()
    wolfSoundPlayer.numberOfLoops = 0

    bgmStruct.setBGM(index: backgroundMusicType)
  }

  func backgroundMusicHandler(){
    bgmStruct.player.stop()

    if backgroundMusicState {
      bgmStruct.player.play()
    }else{
      bgmStruct.player.stop()
    }
  }


  func playSoundEffectWith(soundType: SoundType){
    if soundEffectState {
      switch soundType {
      case .hitSoundEffetct:
        hitSoundEffectPlayer.play()
      case .gameOver:
        gameOverSoundPlayer.play()
      case .celebrate:
        celebrateSoundPlayer.play()
      case .score:
        scoreSoundPlayer.play()
      case .wolf:
        wolfSoundPlayer.play()
      }
    }
  }

  func stopSoundEffectWith(soundType: SoundType){
    switch soundType {
    case .hitSoundEffetct:
      hitSoundEffectPlayer.stop()
    case .gameOver:
      gameOverSoundPlayer.stop()
    case .celebrate:
      celebrateSoundPlayer.stop()
    case .score:
      scoreSoundPlayer.stop()
    case .wolf:
      wolfSoundPlayer.stop()
    }
  }

  func stopAllSoundEffect(){
    hitSoundEffectPlayer.stop()
    gameOverSoundPlayer.stop()
    celebrateSoundPlayer.stop()
    scoreSoundPlayer.stop()
    wolfSoundPlayer.stop()
  }
}
