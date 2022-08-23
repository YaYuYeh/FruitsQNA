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
    @IBOutlet weak var numOfQuestionSlider: UISlider!
    @IBOutlet weak var numOfQuestionLabel: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var readyLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerBackground: UIImageView!
    @IBOutlet weak var decoImage: UIImageView!
    @IBOutlet weak var pronounceButton: UIButton!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var answerButton: UIButton!
    
    //不使用enum直接宣告array
    //let fruitsArray = ["apple", "banana", "blueberry", "cantaloupe", "cherry", "coconut", "grape", "kiwi", "lemon", "lime", "mango", "orange", "peach", ]

    
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
        //測試陣列是否成功產生
        print(fruitsArray)
    }
    
    //顯示題目、題數、隱藏答案
    func aQuestion()
    {
        questionImage.image = UIImage(named: fruitsArray[index])
        numOfQuestionSlider.value = Float(index+1)
        numOfQuestionLabel.text = "\(index+1)/10"
        //答案未公布前，隱藏答案
        answerLabel.text = ""
        //答案未公布前，隱藏發音按鈕
        pronounceButton.isHidden = true
    }
    
    func pronounce()
    {
        let utterance = AVSpeechUtterance(string: fruitsArray[index])
        utterance.rate = 0.4
        utterance.pitchMultiplier = 1.3
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
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
            self.start(nil)
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
        questionImage.isHidden = true
        answerBackground.isHidden = true
        goButton.isHidden = false
        nextButton.isHidden = true
        answerButton.isHidden = true
        pronounceButton.isHidden = true
        
    }
    
    @IBAction func start(_ sender: UIButton!)
    {
        index = 0
        //打亂陣列重排，取代原陣列
        fruitsArray.shuffle()
        aQuestion()
        questionImage.isHidden = false
        readyLabel.isHidden = true
        answerBackground.isHidden = false
        decoImage.isHidden = true
        goButton.isHidden = true
        nextButton.isHidden = false
        answerButton.isHidden = false

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
        answerButton.isEnabled = true
    }
        
    //點擊解答按鈕，顯示答案及發音
    @IBAction func answer(_ sender: Any)
    {
        answerLabel.text = fruitsArray[index]
        //答案公布後，顯示發音按鈕
        pronounceButton.isHidden = false
        answerButton.isEnabled = false
        pronounce()
    }
    
    //發音按鈕
    @IBAction func speak(_ sender: Any)
    {
        pronounce()
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
