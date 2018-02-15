//
//  WeekModel.swift
//  i10WordsDaily
//
//  Created by Mateusz Chojnacki on 15.02.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import Foundation
import RealmSwift

class WeekModel : Object{
    
    @objc dynamic var listName = ""
    let listTenWord = List<WordModel>()
    
    convenience init(listName: String) {
        self.init()
        self.listName = listName
    }
    
    

    
    
}
