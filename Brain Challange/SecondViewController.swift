//
//  SecondViewController.swift
//  Brain Challange
//
//  Created by Apple on 5.01.2019.
//  Copyright © 2019 Selman Comoglu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var gameMode = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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


