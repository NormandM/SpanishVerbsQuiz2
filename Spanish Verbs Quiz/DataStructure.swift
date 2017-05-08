//
//  DataStructure.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-02.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import Foundation
import CoreData

//MARK: Verbe structure
struct VerbeItalien{
    let verbe: String
    let mode: String
    let temps: String
    let premier: String
    let deuxieme: String
    let troisieme: String
    let quatrieme: String
    let cinquieme: String
    let sixieme: String
    var verbeChoisi = [String]()
    let n: Int
    init(verbArray: [[String]], n: Int){
        self.n = n
        verbeChoisi = verbArray[n]
        mode = verbeChoisi[0]
        temps = verbeChoisi[1]
        verbe = verbeChoisi[2]
        premier = verbeChoisi[3]
        deuxieme = verbeChoisi[4]
        troisieme = verbeChoisi[5]
        quatrieme = verbeChoisi[6]
        cinquieme = verbeChoisi[7]
        sixieme = verbeChoisi[8]
    }
}
//////////////////////////////
//// MARK: Struct to assign the right pronom
//////////////////////////////
struct Personne{
    let verbArray: VerbeItalien
    var first: String{
             if verbArray.mode == "Subjuntivo"{
                return "que yo"
             }else if verbArray.mode == "Imperativo"{
                return ""
                
             }else{
                return "yo"
            }
    }
    var second: String{
        if verbArray.mode == "Subjuntivo"{
            return "que tu"
        }else if verbArray.mode == "Imperativo"{
            return"(tu)"
        }else{
            return "tu"
        }
    }
    var third: String {
        if verbArray.mode == "Subjuntivo"{
            return "que el"
        }else if verbArray.mode == "Imperativo"{
            return"(el)"
        }else{
            return "el"
        }
    }
    var fourth: String{
        if verbArray.mode == "Subjuntivo"{
            return "que nosotros"
        }else if verbArray.mode == "Imperativo"{
            return"(nosotros)"
        }else{
            return "nosotros"
        }
    }
    var fifth: String{
        if verbArray.mode == "Subjuntivo"{
            return "que vosotros"
        }else if verbArray.mode == "Imperativo"{
            return"(vosotros)"
        }else{
            return "vosotros"
        }
    }
    var sixth: String {
        if verbArray.mode == "Subjuntivo"{
            return "que ellos"
        }else if verbArray.mode == "Imperativo"{
            return"(ellos)"
        }else{
            return "ellos"
        }
    }

}

/////////////////////////////////////
// MARK: CoreData data controller, persistent store etc
/////////////////////////////////////
open class DataController: NSObject {
    
    static let sharedInstance = DataController()
    
    fileprivate override init() {}
    
    fileprivate lazy var applicationDocumentDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[(urls.endIndex - 1)]
    }()
    
    fileprivate lazy var managerObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "VerbesEspagnols", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    fileprivate lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managerObjectModel)
        let url = self.applicationDocumentDirectory.appendingPathComponent("VerbesEspagnols.sqlite")
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            let userInfo: [String: AnyObject] = [NSLocalizedDescriptionKey: "Failed to initialized the application's saved data" as AnyObject, NSLocalizedFailureReasonErrorKey: "There was an error creating or loading the application's saved data" as AnyObject, NSUnderlyingErrorKey: error as NSError]
            let wrappedError = NSError(domain: "Normand", code: 9999, userInfo: userInfo)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    open lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    open func saveContext() {
        if managedObjectContext.hasChanges{
            do {
                try managedObjectContext.save()
            } catch let error as NSError{
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
////////////////////////////////
// MARK: helper function to capitalisez first letter of string
///////////////////////////////
class Helper {
    func capitalize(word: String) -> (String) {
        let firstLetter =  String(word.characters.prefix(1)).capitalized
        let otherLetters = String(word.characters.dropFirst())
        return(firstLetter + otherLetters)
    }
}

