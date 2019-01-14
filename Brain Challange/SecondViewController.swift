//
//  SecondViewController.swift
//  Brain Challange
//
//  Created by Apple on 5.01.2019.
//  Copyright © 2019 Selman Comoglu. All rights reserved.
//

import UIKit

import ChameleonFramework



class SecondViewController: UIViewController {

    
    let defaults = UserDefaults.standard
 
    var gameMode = ""
 
    @IBOutlet weak var highScore: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
     self.navigationController?.hidesNavigationBarHairline = true
        
        musicButton.isOn = defaults.bool(forKey: "MusicState")
        
        hintButton.isOn = defaults.bool(forKey: "HintState")

    }
    
    @IBOutlet weak var hintButton: UISwitch!
    @IBOutlet weak var musicButton: UISwitch!

    
    @IBAction func hintChanged(_ sender: UISwitch) {
        if hintButton.isOn{
          
            defaults.set(true, forKey: "HintState")
            
        }
        else{
            
            defaults.set(false, forKey: "HintState")
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
        
        if (sender.title(for: .normal)!) == "Classic" {
        gameMode = "normal"
        }
        else{
            gameMode = "hard"
        }
         performSegue(withIdentifier: "goNextPage", sender: self)
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if gameMode == "normal"{
            let secondVC = segue.destination as! ViewController
            
            secondVC.gameLevel = gameMode
            
        }
        else
        {
            let secondVC = segue.destination as! ViewController
            
            secondVC.gameLevel = gameMode
            
        }
    }
    
    
    
 
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


