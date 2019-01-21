//
//  SecondViewController.swift
//  Brain Challange
//
//  Created by Apple on 5.01.2019.
//  Copyright © 2019 Selman Comoglu. All rights reserved.
//

import UIKit
import SVProgressHUD


class LaunchViewController: UIViewController {

    
    let defaults = UserDefaults.standard
 
    var gameMode = "start"
    var hintMode :Bool?
    
    @IBOutlet weak var highScore: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
//    gameMode = ""
     print(gameMode)
        
       // self.navigationController?.hidesNavigationBarHairline = true
        
        musicButton.isOn = defaults.bool(forKey: "MusicState")
        
        hintButton.isOn = defaults.bool(forKey: "HintState")
        hintMode = hintButton.isOn
    }

    @IBOutlet weak var hintButton: UISwitch!
    @IBOutlet weak var musicButton: UISwitch!
    
    @IBAction func hintChanged(_ sender: UISwitch) {
        if hintButton.isOn{
          
            defaults.set(true, forKey: "HintState")
            hintMode = true
        }
        else{
            defaults.set(false, forKey: "HintState")
            hintMode = false
        }
    }
    
    @IBAction func musicChanged(_ sender: UISwitch) {
        
       // musicButton.isOn = !musicButton.isOn
        //bu üstteki de true ise false yap, false ise true yap. tek satır kod!!
        
//        if musicButton.isOn{
//
//            defaults.set(true, forKey: "MusicState")
//        }
//        else{
//
//            defaults.set(false, forKey: "MusicState")
//        }
      
        // yukarıdaki kod ile tamamen aynı şeyi yapıyor
        
        musicButton.isOn == true ? defaults.set(true, forKey: "MusicState") : defaults.set(false, forKey: "MusicState")
            }
    
    @IBAction func anyButtonPressed(_ sender: UIButton) {
        
        switch (sender.title(for: .normal)!){
        case "Classic":
        
        gameMode = "normal"
        
        performSegue(withIdentifier: "goNextPage", sender: self)
        
        case "Extreme":
        gameMode = "hard"
        performSegue(withIdentifier: "goNextPage", sender: self)
        
        case "Scores":
        gameMode = "start"
        performSegue(withIdentifier: "goToScores", sender: self)
        default:
            return
        }
       
       print(gameMode)
    
      
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goNextPage"{
         
            let secondVC = segue.destination as! FirstViewController
            secondVC.gameLevel = gameMode
            secondVC.hintUse = hintMode
        }
        else if segue.identifier == "goToScores"{
            SVProgressHUD.show()
            _ = segue.destination as! HighScoreViewController
        
        }
        
    }

    }
