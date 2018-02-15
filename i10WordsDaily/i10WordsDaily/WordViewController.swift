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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.currentWeek.listTenWord.count
    }
    
    func updateUI(){
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell") as! WordTableViewCell
        
        let randomNum:UInt32 = arc4random_uniform(2)
        
        if(randomNum == 0){
            cell.wordLabel.text = self.currentWeek.listTenWord[indexPath.row].wordPL
            cell.bgImage.image =  UIImage(contentsOfFile: "flagPL")
            self.realm.updateIsPL(weekModel: currentWeek, index: indexPath.row, isPL: true)
        }else if (randomNum == 1){
            cell.wordLabel.text = self.currentWeek.listTenWord[indexPath.row].wordPL
            cell.bgImage.image =  UIImage(contentsOfFile: "flagGB")
            self.realm.updateIsPL(weekModel: currentWeek, index: indexPath.row, isPL: false)
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: nil, action: Selector("addWord"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addWord(){
        print("hello")
    }
}
