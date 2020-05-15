//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by Shu Fujita on 2020/05/15.
//  Copyright © 2020 Fujita shu. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imgView1: UIImageView!//上の画像
    @IBOutlet var imgView2: UIImageView!//真ん中の画像
    @IBOutlet var imgView3: UIImageView!//下の画像
    @IBOutlet var resultLabel: UILabel!//スコア
    
    @IBAction func stop(){
        if timer.isValid == true{
            timer.invalidate()}
        for i in 0..<3{
            score = score - abs(Int(width/2 - positionX[i]))*2}//スコアの計算
            resultLabel.text = "Score : " + String(score)//結果ラベルに表示
            resultLabel.isHidden = false //結果ラベルを隠さない
        
        let highScore1: Int = defaults.integer(forKey: "score1")//ユーザデフォルトにscore1というキーの値を取得
        let highScore2: Int = defaults.integer(forKey: "score2")
        let highScore3: Int = defaults.integer(forKey: "score3")
        
        if score > highScore1{//１位の記録を更新
            defaults.set(score, forKey:"score1")//scoreの保存
            defaults.set(highScore1, forKey:"score2")//score2で前の記録保存
            defaults.set(highScore2, forKey:"score3")}//score3でhighscore2を保存
        else if score > highScore2{//ランキング2位の記録更新
            defaults.set(score, forKey:"score2")
            defaults.set(highScore2, forKey:"score3")
        }
        else if score > highScore3{
            defaults.set(score, forKey:"score3")//score3でscoreを保存
        }
    }
    
    @IBAction func retry(){
        score = 1000//スコアのリセット
        positionX = [width/2, width/2, width/2]//画像の位置を真ん中に戻す
        if timer.isValid == false{
            self.start()}
    }
    
    @IBAction func toTop(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func up(){
              for i in 0..<3{  //端で動かす向きを逆に
                if positionX[i] > width || positionX[i] < 0{
                    dx[i] = dx[i] * (-1)
                }
              positionX[i] += dx[i] //画像の位置をdx分ずらす
          }
    imgView1.center.x = positionX[0]//上の画像をずらした位置に移動
    imgView2.center.x = positionX[1]
    imgView3.center.x = positionX[2]
    }
    var timer: Timer! //画像タイマー
    var score: Int = 1000 //スコア値
    let defaults: UserDefaults = UserDefaults.standard //スコアの保存
    
    let width: CGFloat = UIScreen.main.bounds.size.width //画面幅
    
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]//画像の位置
    
    var dx: [CGFloat] = [1.0, 0.5, -1.0]//画像を動かす幅
    
    func start(){
        resultLabel.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self,
                                     selector: #selector(self.up), userInfo: nil, repeats: true)
        timer.fire()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        positionX = [width/2, width/2, width/2]
        self.start()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
