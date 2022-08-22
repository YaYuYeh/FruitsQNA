//
//  FruitViewController.swift
//  FruitsQNA
//
//  Created by Ya Yu Yeh on 2022/8/21.
//

import UIKit
import AVFoundation

class FruitViewController: UIViewController
{
    @IBOutlet weak var numOfQestionSlider: UISlider!
    @IBOutlet weak var numOfQuestionLabel: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var pronounceButton: UIButton!
    
    //不使用直接宣告array，使用列舉產生陣列
    //let qnaArray = ["apple", "banana", "blueberry", "cantaloupe", "cherry", "coconut", "grape", "kiwi", "lemon", "lime", "mango", "orange", "peach", ]

    
    var index = 0
    //宣告一個水果空陣列(String)
    var fruitsArray = [String]()
    
    //產生所有的水果
    func allFruits()
    {
        //使用allCass屬性列出列舉中所有的case，並配合迴圈產生陣列
        for fruit in QnA.allCases
        {
            let oneFruit = fruit.rawValue
            fruitsArray.append(oneFruit)
        }
    }
    
    //顯示題目、題數、隱藏答案
    func aQuestion()
    {
        questionImage.image = UIImage(named: fruitsArray[index])
        numOfQestionSlider.value = Float(index+1)
        numOfQuestionLabel.text = "\(index+1)/10"
        answerLabel.text = ""
        //答案未公布前，隱藏發音按鈕
        pronounceButton.isHidden = true
    }
    
    //再玩一次
    func replayAction()
    {
        //打亂陣列重排，取代原陣列
        fruitsArray.shuffle()
        index = 0
        aQuestion()
        //遊戲開始前顯示的訊息
        answerLabel.text = "Are you ready?"
    }
    
    //結束遊戲的訊息視窗
    func alertMessage()
    {
        //透過UIAlertController產生訊息視窗->詢問是否再玩一次
        let alertController = UIAlertController(title: "Well Done!", message: "Try again?", preferredStyle: .alert)
        //利用UIAlertAction產生視窗上選取的按鈕
        //確認按鈕，並透過handler參數傳入閉包 控制點選按鈕要做的事情->再玩一次
        //閉包取作用域外的function，要加self.
        let okAction = UIAlertAction(title: "Sure", style: .default) { _
            in
            self.replayAction()
        }
        //取消按鈕，.destructive為警告樣式，文字顯示紅色
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        //利用addAction將按鈕加入訊息視窗中
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        //顯示提示視窗
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //放viewDidLoad()中，打開app會產生列舉中的所有水果成員
        allFruits()
        //打亂陣列重排，取代原陣列
        fruitsArray.shuffle()
        aQuestion()
        //遊戲開始前顯示的訊息
        answerLabel.text = "Are you ready?"
    }
    
    //點擊下一題按鈕，顯示下題圖片、題數、更換答案
    @IBAction func next(_ sender: Any)
    {
        if index == 9
        {
            alertMessage()
        }
        else
        {
            index += 1
            aQuestion()
        }
    }
        
    //點擊解答按鈕，顯示答案
    @IBAction func answer(_ sender: Any)
    {
        answerLabel.text = fruitsArray[index]
        //答案公布後，顯示發音按鈕
        pronounceButton.isHidden = false
    }
    
    //發音按鈕
    @IBAction func pronounce(_ sender: Any)
    {
        let utterance = AVSpeechUtterance(string: fruitsArray[index])
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.5
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
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
