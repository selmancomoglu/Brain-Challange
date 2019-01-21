//
//  HighScoreViewController.swift
//  Brain Challange
//
//  Created by Apple on 14.01.2019.
//  Copyright © 2019 Selman Comoglu. All rights reserved.
//

import UIKit
import ChameleonFramework
import FirebaseCore
import SVProgressHUD
import FirebaseAnalytics
import FirebaseDatabase

class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var viewBack: UIView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageArray.count
    }
    var indexNumber = [Int]()
    
   
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
              navigationController?.popToRootViewController(animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "reuseIdentifier")
        }
        
        cell?.textLabel?.text = self.messageArray[indexPath.row].sender
        cell?.detailTextLabel?.text = self.messageArray[indexPath.row].messageBody
        
        cell?.backgroundColor = UIColor.flatWhite()
        cell?.textLabel?.textColor = UIColor.flatNavyBlue()
        
        
        
        SVProgressHUD.dismiss()
        
        
        return cell!
    }
   
    
    @IBOutlet weak var messageTableView: UITableView!
    
    var messageArray : [Message] = [Message]()
    
   
    //*MARK * viewdidload
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewBack.backgroundColor = UIColor.flatGray()
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        retrieveMessages()
        
         messageTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        //        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil) , forCellReuseIdentifier: "customMessageCell")
        
    }
    
    func retrieveMessages(){
        var count = 0
        let messageDB = Database.database().reference().child("Scores")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, Any>
            let name = snapshotValue["Player"]!
            let score = snapshotValue["Score"]!
            
            let message = Message()
            

            message.sender = "\(name)" 
            message.messageBody = "\(score)"
            
            count += 1
            self.indexNumber.append(count)
            
              self.messageArray.sort(by: {$0.messageBody < $1.messageBody})
            
            self.messageArray.append(message)
            self.messageTableView.reloadData()
            
            print(name, score)
            
            
        }
      
        
      
        
    }
   
   
   
}
