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
    @IBOutlet weak var numberSlider: UISlider!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var pronounceButton: UIButton!
    
    //let qnaArray = ["apple", "banana", "blueberry", "cantaloupe", "cherry", "coconut", "grape", "kiwi", "lemon", "lime", "mango", "orange", "peach", ]

    
    var index = 0
    //宣告一個水果空陣列(String)
    var fruitsArray = [String]()
    
    //產生所有的水果
    func allFruits()
    {
        for fruit in QnA.allCases
        {
            let oneFruit = fruit.rawValue
            fruitsArray.append(oneFruit)
        }
    }
    
    func allert()
    {
        let message = UIAlertController(title: "congratulations!", message: "well done!", preferredStyle: .alert)
        let replayAction = UIAlertAction(title: "try again", style: .default, handler: nil)
        message.addAction(replayAction)
        present(message, animated: true, completion: nil)
    }
    
    func replayAction()
    {
        fruitsArray.shuffle()
        index = 0
        questionImage.image = UIImage(named: fruitsArray[index])
        numberSlider.value = Float(index+1)
        numberLabel.text = "\(index+1)/10"
        answerLabel.text = "加油！"
        //答案未公布前，隱藏發音按鈕
        pronounceButton.isHidden = true
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //放viewDidLoad()中，打開app會產生列舉中的所有水果成員
        allFruits()
        //打亂陣列重排，取代原陣列
        fruitsArray.shuffle()
    }
    
    //點擊解答按鈕，顯示答案
    @IBAction func answer(_ sender: Any)
    {
        answerLabel.text = fruitsArray[index]
        //答案未公布後，顯示發音按鈕
        pronounceButton.isHidden = false
    }
    
    //點擊下一題按鈕，顯示下題圖片、題數、答案label更換
    @IBAction func next(_ sender: Any)
    {
        if index == 9
        {
            allert()
        }
        else
        {
            index += 1
            questionImage.image = UIImage(named: fruitsArray[index])
            numberSlider.value = Float(index+1)
            numberLabel.text = "\(index+1)/10"
            answerLabel.text = "加油！"
            //答案未公布前，隱藏發音按鈕
            pronounceButton.isHidden = true
        }
        
        
    }
    
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
