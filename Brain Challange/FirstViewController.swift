//
//  ViewController.swift
//  Brain Challange
//
//  Created by Apple on 11.12.2018.
//  Copyright © 2018 Selman Comoglu. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class FirstViewController: UIViewController {
    
    let defaults = UserDefaults.standard

   
    
    
    @IBOutlet var myButtons: [UIButton]!
    
  
    var hintUse :Bool?
    
    var gameLevel = ""
    
    var startTime = TimeInterval()
    var currentTime: Double = 0.0
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    
   var randomNumberShort = [26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
    
   var randomNumberAll = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
    
    var checkedNumber : Int = 1
    
    var playerName : String = ""
    var playerScore : Double = 0.0
    
    @IBOutlet weak var testB: UIButton!
    
    @IBOutlet weak var nextNumber: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!

    @IBOutlet weak var bestScoreLabel: UILabel!
    
    
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(hintUse!)
        startTimer()
        self.navigationController?.hidesNavigationBarHairline = true
        
        if let bestScore = defaults.string(forKey: "PlayerBestScore"){
            bestScoreLabel.text = bestScore
            
        }
            
 
      randomNumberShort.shuffle()
      getRandomTest()
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    

    
    
   func enterUserName(){
    /////////
    let alertController = UIAlertController(title: "See Your Rank!", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Add Player's Name"
        }
    let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let userTextField = alertController.textFields![0] as UITextField
            //let userScore = alertController.textFields![1] as UITextField


        self.playerName = userTextField.text!


        })


    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
        (action : UIAlertAction!) -> Void in })

    alertController.addAction(saveAction)
    alertController.addAction(cancelAction)


    self.present(alertController, animated: true, completion: nil)


    ///////////////
    
    let messageDB = Database.database().reference().child("Scores")
    
    let myInt = (timerLabel.text! as NSString).doubleValue
    playerScore = myInt
    
    if let oldScore = Double(bestScoreLabel.text!) {
        if myInt <= oldScore{
            defaults.set(timerLabel.text, forKey: "PlayerBestScore")
            bestScoreLabel.text = NSString(format: "%2.f", playerScore as CVarArg) as String
        }
        else{
            print("try your best!")
        }
    }
    
    
    let messageDictionary = ["Player": playerName ,
                             "Score": playerScore] as [String : Any]
    messageDB.childByAutoId().setValue(messageDictionary){
        (error, reference) in
        
        if error != nil {
            print(error!)
        }
        else {
            print("Message saved successfully!")
            
        }
    } 
    }
    
    @IBAction func testDB(_ sender: Any) {
        pauseTimer()
        
        let myInt = (timerLabel.text! as NSString).doubleValue
        playerScore = myInt
     //   enterUserName()
        performSegue(withIdentifier: "resultPage", sender: self)
       

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "resultPage"{
            
            let secondVC = segue.destination as! ResultViewController
            secondVC.gameResult = playerScore
            //secondVC.playerName = playerName
            
            print(playerScore)
            print(secondVC.gameResult!)
           
        }
    }
    
    
    @IBAction func resetNumbers(_ sender: UIButton) {
       
        checkedNumber = 1
        getRandomTest()
        resetTimer()
        
        nextNumber.text = String(checkedNumber)
        
        var counter = 0
        for button in myButtons{
            button.backgroundColor = UIColor(red: 0.2039, green: 0.6745, blue: 0.8784, alpha: 1.0)
            if counter < 24 {
                counter = counter + 1}
        }
    }
    
    
    
    
    
    @IBAction func anyButtonPressed(_ sender: UIButton) {
        
       // Try again! I think you can do it well!
        //startTimer()
        
        switch (gameLevel, checkedNumber){
        case ("normal",1...25):
                if checkedNumber == Int(sender.title(for: .normal)!)
                {
                    sender.blink(enabled:false) // BU OLMADI
                    sender.backgroundColor = UIColor(red: 0.6667, green: 0.5882, blue: 0.8549, alpha: 1.0)
                    sender.setTitle("\(String(describing: randomNumberShort[checkedNumber - 1]))", for: .normal)
                    checkedNumber = checkedNumber + 1
                    nextNumber.text = "\(checkedNumber)"
                   // DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
                        // Your code with delay
                    if hintUse == true{
                        for button in self.myButtons{
                            if Int(button.currentTitle!) == self.checkedNumber{
                                    button.blink()
                                print(timerLabel.text!)
                    }}}}
                else{
                    print("wrong button")
                    sender.shake(count: 4, for: 0.1, withTranslation: 3)
                }
                
        case ("normal",26...50):
                if checkedNumber == Int(sender.title(for: .normal)!)
                {
                    sender.blink(enabled:false)// BU OLMADI
                    sender.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
                    checkedNumber = checkedNumber + 1
                    nextNumber.text = "\(checkedNumber)"
                        for button in self.myButtons{
                            if Int(button.currentTitle!) == self.checkedNumber{
                                print(button.currentTitle!)
                                    button.blink()
                    }}}
                else{
                    print("wrong button")
                    sender.shake(count: 4, for: 0.1, withTranslation: 3)
            }
 
        case ("hard", 1...50):
                if checkedNumber == Int(sender.title(for: .normal)!)
                {
                    checkedNumber = checkedNumber + 1
                    nextNumber.text = "\(checkedNumber)"
                    getRandomTest()
                }
    
            default:
                return
            }
    
    
        
        
        
        if checkedNumber == 51
        {
            
            nextNumber.text = "Congrats"
            pauseTimer()
            
            for button in myButtons{
                
                button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
                
            }
            
            enterUserName()
        }
    }




    func getRandomTest()
    {
    randomNumberAll.shuffle()
       var counter = 0
        for number in randomNumberAll{
            if number <= 25 && checkedNumber <= 25
            {
                myButtons[counter].setTitle("\(number)", for: .normal)
                counter = counter + 1
            }}
        for number in randomNumberAll{
            if number > 25 && checkedNumber > 25
            {
                myButtons[counter].setTitle("\(number)", for: .normal)
                counter = counter + 1
            }
            }
        }
    
       func getRandomNew(){
        
        var counter = 0
        for number in randomNumberAll{
            if number <= 25 && checkedNumber <= 25
            {
                myButtons[counter].setTitle("\(number)", for: .normal)
                counter = counter + 1
            }}
       }
//
//        randomNumberArray1.shuffle()
//
//    var counter = 0
//        for button in myButtons{
//
//            button.setTitle("\(String(describing: randomNumberArray1[counter]))", for: .normal)
//            if counter < 24 {
//                counter = counter + 1}
//         }
//        }
//
//    func getRandomNumbers2(){
//        randomNumberArray2.shuffle()
//        var counter = 0
//        for button in myButtons{
//            button.setTitle("\(String(describing: randomNumberArray2[counter]))", for: .normal)
//            if counter < 24 {
//                counter = counter + 1}
//        }
//    }
    
    func startTimer() {
        if(isPlaying) {
           
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        
        
        isPlaying = true
    }
    
    func pauseTimer() {
        timer.invalidate()
        isPlaying = false
    }
    
    func resetTimer() {
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        timerLabel.text = String(counter)
    }
    
    @objc func UpdateTimer() {
        counter = counter + 0.01
        timerLabel.text = String(format: "%.2f", counter)
        
         currentTime = counter
        if currentTime + 3 < counter {
            print("test")
        }
    }
}

public extension UIView {
    
    func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {
        
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: CGFloat(-translation), y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: CGFloat(translation), y: self.center.y))
        layer.add(animation, forKey: "shake")
    }
}

extension UIButton {
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self.bounds.contains(point) ? self : nil
    }
    func blink(enabled: Bool = true, duration: CFTimeInterval = 1.0, stopAfter: CFTimeInterval = 0.0 ) {
        enabled ? (UIView.animate(withDuration: duration, //Time duration you want,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 0.0 },
            completion: { [weak self] _ in self?.alpha = 1.0 })) : self.layer.removeAllAnimations()
        if !stopAfter.isEqual(to: 0.0) && enabled {
            DispatchQueue.main.asyncAfter(deadline: .now() + stopAfter) { [weak self] in
                self?.layer.removeAllAnimations()
            }
        }
    }
    
    
    
        
    }



//    startTimer()
//        switch checkedNumber{
//        case 1...25:
//            if (gameLevel == "normal") && checkedNumber == Int(sender.title(for: .normal)!)
//                 {
//                    sender.backgroundColor = UIColor(red: 245/255, green: 205/255, blue: 121/255, alpha: 1.0)
//                    sender.setTitle("\(randomNumberArray2[checkedNumber - 1])", for: .normal)
//                    checkedNumber = checkedNumber + 1
//                    nextNumber.text = "\(checkedNumber)"
//                }
//            else if (gameLevel == "hard") && (checkedNumber == Int(sender.title(for: .normal)!))
//                     {
//                        checkedNumber = checkedNumber + 1
//                        nextNumber.text = "\(checkedNumber)"
//                      getRandomTest()
//            }
//
//        case 26...50:
//
//            if (gameLevel == "normal") && (checkedNumber == Int(sender.title(for: .normal)!) ){
//               sender.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
//                checkedNumber = checkedNumber + 1
//                nextNumber.text = "\(checkedNumber)"
//            }
//
//            else if (gameLevel == "hard") && (checkedNumber == Int(sender.title(for: .normal)!)){
//                 checkedNumber = checkedNumber + 1
//                nextNumber.text = "\(checkedNumber)"
//                getRandomTest()
//                }
//
//            if checkedNumber == 51{
//
//                nextNumber.text = "Congrats"
//                pauseTimer()
//
//                for button in myButtons{
//
//                    button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)}
//
//                enterUserName()
//          }
//        default:
//            print("can not be nil")
//        }
