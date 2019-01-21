//
//  ResultViewController.swift
//  Brain Challange
//
//  Created by Apple on 21.01.2019.
//  Copyright © 2019 Selman Comoglu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var playerName :String?{
        didSet{
            print("data entry Name")
        }
    }
    var gameResult :Double?{
        didSet{
            print("data entry Score")
            
        }
    }
    
    @IBAction func getResultPressed(_ sender: Any) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        scoreLabel.text = "Your Score: " + (NSString(format: "%.2f", gameResult!) as String) as String
       
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    

}
