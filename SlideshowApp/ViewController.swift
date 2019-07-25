//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 板垣有祐 on 2019/07/24.
//  Copyright © 2019 Swift-Beginner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    // ボタン制御(タップ禁止)のための宣言
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    
    // 表示している画像の番号
    var displayImageNo = 0
    
    // 画像の名前の配列
    let imageNameArray = ["pug1", "cat1", "dog2", "pug1", "cat1"]
    
    // 一定の間隔で処理を行うためのタイマー
    var timer: Timer!
    
    // 表示している画像の番号を元に画像を表示する
    func displayImage() {
        
        // 表示している画像の番号から名前を取り出し
        let name = imageNameArray[displayImageNo]
        
        // 画像を読み込み
        let image = UIImage(named: name)
        
        // Image Viewに読み込んだ画像をセット
        imageView.image = image
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 初期画面
        // バンドルした画像ファイルを読み込み
        // Image Viewに画像を設定
        let image = UIImage(named: "pug1")
        imageView.image = image
        
        
    }

    // 進むボタン
    @IBAction func nextButtonTap(_ sender: Any) {
        if displayImageNo < imageNameArray.count - 1 {
            // 表示している画像の番号を1増やす
            displayImageNo += 1
            // 表示している画像の番号を元に画像を表示する
            displayImage()
            print(displayImageNo) // 取得インデックスの確認
        } else {
            displayImageNo = 0
            displayImage()
            print(displayImageNo) // 取得インデックスの確認
        }
    }
    
    // 戻るボタン
    @IBAction func backButtonTap(_ sender: Any) {
        if displayImageNo  >= 1 && displayImageNo  <= imageNameArray.count - 1  {
            // 表示している画像の番号を1減らす
            displayImageNo -= 1
            // 表示している画像の番号を元に画像を表示する
            displayImage()
            print(displayImageNo) // 取得インデックスの確認
        }  else {
            displayImageNo = imageNameArray.count - 1
            displayImage()
            print(displayImageNo) // 取得インデックスの確認
        }
    }
    
    // 再生・停止ボタン
    @IBAction func switchButtonTap(_ sender: Any) {
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        if self.timer == nil {
            // タイマーを設定
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            // 再生・停止ボタンタップ時に進むボタン・戻るボタンのタップ非表示
            nextButton.isEnabled = false
            backButton.isEnabled = false
            // ボタンの名前を停止とする
            switchButton.setTitle("停止", for: .normal)
             // 背景色・ボタン内テキストサイズを変更
            self.view.backgroundColor = UIColor.lightGray
            switchButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
            
        } else if self.timer != nil {
            // タイマーを停止
            self.timer.invalidate()
            // nil にして再び再生(nil の時にタイマー生成)
            self.timer = nil
            // 再生・停止ボタンタップ時に進むボタン・戻るボタンのタップ非表示
            nextButton.isEnabled = true
            backButton.isEnabled = true
            // ボタンの名前を再生とする
            switchButton.setTitle("再生", for: .normal)
            // 背景色・ボタン内テキストサイズを戻す
            self.view.backgroundColor = UIColor.white
            switchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        }
        
    }
    
    // #selectorで呼び出される関数
    @objc func updateTimer(_ timer: Timer) {
        // 進むボタンの内容を行う
        if displayImageNo < imageNameArray.count - 1 {
            // 表示している画像の番号を1増やす
            displayImageNo += 1
            // 表示している画像の番号を元に画像を表示する
            displayImage()
            print(displayImageNo) // 取得インデックスの確認
        } else {
            displayImageNo = 0
            displayImage()
            print(displayImageNo) // 取得インデックスの確認
        }
    }
    
    
    // 表示画像をタップし、画面遷移を行う
    @IBAction func onTapAction(_ sender: Any) {
       self.performSegue(withIdentifier: "toZoomIn", sender: nil)
    }
    
    // 遷移元から遷移先にデータ(画像)を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のResultViewControllerを取得する
        let zoomInViewController:ZoomInViewController = segue.destination as! ZoomInViewController
        
        // ここから直したーーーーーーーい
        // 表示している画像の番号から名前を取り出し
        let name = imageNameArray[displayImageNo]
        // 画像を読み込み
        let image = UIImage(named: name)
         // ここまで直したーーーーーーーい
        
        zoomInViewController.selectedImg = image
    }
    
    // 画面遷移後の画面から「戻る」で帰ってくる
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
}

