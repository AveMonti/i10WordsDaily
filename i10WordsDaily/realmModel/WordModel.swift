//
//  WordModel.swift
//  i10WordsDaily
//
//  Created by Mateusz Chojnacki on 15.02.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import Foundation
import RealmSwift

class WordModel : Object{
        @objc dynamic var wordPL = ""
        @objc dynamic var wordENG = ""
        @objc dynamic var isDone: Bool = false
    
        convenience init(wordPL: String, wordENG: String) {
            self.init()
            self.wordPL = wordPL
            self.wordENG = wordENG
        }    
}
