//
//  ViewController.swift
//  i10WordsDaily
//
//  Created by Mateusz Chojnacki on 15.02.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import UIKit
import RealmSwift

class WeekViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var realm = RealmService.shared
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.realm.getAll().count
    }
    
    func updateUI(){
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekCell") as! WeekTableViewCell
        cell.weekLabel.text = self.realm.getAll()[indexPath.row].listName
        
        return cell
    }


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addWeek(_ sender: Any) {
        self.displayAlert(currentWeek: nil)
    }
    

    func displayAlert(currentWeek: WeekModel?){
        
        
        let alert = UIAlertController(title: "New list", message: "Add the name of your task list ", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            if (currentWeek != nil){
                
                self.realm.update(weekModel: currentWeek!, listName: textField.text!)
                self.updateUI()
            }else{
                
                let newWeek = WeekModel(listName: textField.text!)
                self.realm.create(weekModel: newWeek)
                self.updateUI()
            }
        }
        alert.addTextField { (textField) in
            if(currentWeek != nil){
                textField.placeholder = currentWeek?.listName
            }else{
                textField.placeholder = "Add your list name"
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
            self.displayAlert(currentWeek: self.realm.getAll()[indexPath.row])
            success(true)
        })
        modifyAction.image = UIImage(named: "hammer")
        modifyAction.backgroundColor = .purple
        
        
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.realm.delete(weekModel: self.realm.getAll()[indexPath.row])
            self.updateUI()
            success(true)
        })
        deleteAction.image = UIImage(named: "hammer")
        deleteAction.backgroundColor = UIColor.red
        
        return UISwipeActionsConfiguration(actions: [deleteAction,modifyAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = UITableViewCellSelectionStyle.none
        let detailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsVC") as! WordViewController
        detailsVC.currentWeek = realm.getAll()[indexPath.row]
        show(detailsVC, sender: self)
    }
}

