//
//  WordViewController.swift
//  i10WordsDaily
//
//  Created by Mateusz Chojnacki on 15.02.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import UIKit

class WordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    var realm = RealmService.shared
    var currentWeek = WeekModel()
    @IBOutlet weak var tableView: UITableView!
    var ifFirstTimeOpen = true
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.currentWeek.listTenWord.count
    }
    
    func updateUI(){
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell") as! WordTableViewCell
        
        
        if(ifFirstTimeOpen == true){
            let randomNum:UInt32 = arc4random_uniform(2)
            
            if(randomNum == 0){
                cell.wordLabel.text = self.currentWeek.listTenWord[indexPath.row].wordPL
                cell.bgImage.image =   UIImage(named: "flagPL")
                self.realm.updateIsPL(weekModel: currentWeek, index: indexPath.row, isPL: true)
            }else if (randomNum == 1){
                cell.wordLabel.text = self.currentWeek.listTenWord[indexPath.row].wordENG
                cell.bgImage.image =   UIImage(named: "flagGB")
                self.realm.updateIsPL(weekModel: currentWeek, index: indexPath.row, isPL: false)
            }
            
            self.ifFirstTimeOpen = false
        }else{
            if(self.currentWeek.listTenWord[indexPath.row].isPL == true){
                cell.wordLabel.text = self.currentWeek.listTenWord[indexPath.row].wordPL
                cell.bgImage.image =   UIImage(named: "flagPL")
            }else{
                cell.wordLabel.text = self.currentWeek.listTenWord[indexPath.row].wordENG
                cell.bgImage.image =   UIImage(named: "flagGB")
            }
        }


        
        
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(_ sender: Any) {
        self.displayAlert(index: nil)
    }
    
    func displayAlert( index: Int?){
        
        
        let alert = UIAlertController(title: "New list", message: "Add the name of your task list ", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let textFieldPL = alert.textFields![0] as UITextField
            let textFieldENG = alert.textFields![0] as UITextField
            if (index != nil){
                
                self.realm.updateWord(weekModel: self.currentWeek, index: index!, wordPL: textFieldPL.text!, wordENG: textFieldENG.text!)
                self.updateUI()
            }else{
                
                let newWeek = WordModel(wordPL: textFieldPL.text!, wordENG: textFieldENG.text!)
                self.realm.addWord(weekModel: self.currentWeek, wordModel: newWeek)
                self.updateUI()
            }
        }
        alert.addTextField { (textFieldPL) in
            if(index != nil){
                textFieldPL.placeholder = self.currentWeek.listTenWord[index!].wordPL
            }else{
                textFieldPL.placeholder = "Word PL"
            }
        }
        alert.addTextField { (textFieldENG) in
            if(index != nil){
                textFieldENG.placeholder = self.currentWeek.listTenWord[index!].wordENG
            }else{
                textFieldENG.placeholder = "Word ENG"
            }
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.displayAlert(index: indexPath.row)
            success(true)
        })
        modifyAction.image = UIImage(named: "hammer")
        modifyAction.backgroundColor = .purple
        
        
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.realm.deleteWord(weekModel: self.currentWeek, index: indexPath.row)
            self.updateUI()
            success(true)
        })
        deleteAction.image = UIImage(named: "hammer")
        deleteAction.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [deleteAction,modifyAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = UITableViewCellSelectionStyle.none
        
        let isPL = self.currentWeek.listTenWord[indexPath.row].isPL
        self.realm.updateIsPL(weekModel: self.currentWeek, index: indexPath.row, isPL: !isPL)
        self.updateUI()
    }
    
    
}
