//
//  RealmService.swift
//  i10WordsDaily
//
//  Created by Mateusz Chojnacki on 15.02.2018.
//  Copyright © 2018 Mateusz Chojnacki. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService{
    private init(){} //singleTone
    static let shared = RealmService()
    
    
    var realm = try! Realm()
    
    // WeekModel
    
    func getAll() ->[WeekModel]{
        let resoults: Results<WeekModel> = realm.objects(WeekModel.self)
        return Array(resoults)
    }
    
    func create(weekModel: WeekModel){
        do{
            try realm.write {
                realm.add(weekModel)
            }
        } catch let error as NSError{
            post(error)
        }
    }
    
    func delete(weekModel: WeekModel){
        do{
            try realm.write {
                realm.delete(weekModel)
            }
        } catch let error as NSError{
            post(error)
        }
    }
    
    func update(weekModel: WeekModel,listName: String){
        do{
            try realm.write {
                if(listName != ""){
                    weekModel.listName = listName
                }
            }
        } catch let error as NSError{
            post(error)
        }
    }
    
    // WordModel
    
    
    func addWord(weekModel: WeekModel, wordModel: WordModel){
        do{
            try realm.write {
                weekModel.listTenWord.append(wordModel)
            }
        } catch let error as NSError{
            post(error)
        }
    }
    
    func deleteWord(weekModel: WeekModel, index: Int){
        do{
            try realm.write {
                weekModel.listTenWord.remove(at: index)
            }
        } catch let error as NSError{
            post(error)
        }
    }
    
    func updateWord(weekModel: WeekModel, index : Int, wordPL: String?, wordENG: String? ){
        do{
            try realm.write {
                if(wordPL != nil){
                    weekModel.listTenWord[index].wordPL = wordPL!
                }
                if(wordENG != nil){
                    weekModel.listTenWord[index].wordENG = wordENG!
                }
            }
        } catch let error as NSError{
            post(error)
        }
    }
    
    func updateIsPL(weekModel: WeekModel, index : Int, isPL: Bool ){
        do{
            try realm.write {
                    weekModel.listTenWord[index].isPL = isPL
            }
        } catch let error as NSError{
            post(error)
        }
    }
    
    
    /// Notyfication Center
    func post(_ error: Error){
        NotificationCenter.default.post(name: NSNotification.Name("RealmError"), object: error)
    }
}
