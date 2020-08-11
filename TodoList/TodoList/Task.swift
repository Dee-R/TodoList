//
//  Meal.swift
//  TodoList
//
//  Created by Eddy R on 07/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//
import Foundation
import CoreData
class Task{
  // MARK: - Properties
  var name:String?
  
  // MARK: - Types
  struct PropertyKey {
    static let name = "name"
  }
  
  // MARK: - Initialization
  init?(name:String) {
    
    // the name must not be empty
    guard !name.isEmpty else {
      return nil
    }
    
    // Initialize stored properties.
    self.name = name
  }
}


/**
 Core data : 5 classes 3 files
 NSManagedObjectModel
 NSPersistentStoreCoordinator
 NSManagedObjectContext
 NSManagedObject
 NSPersistentContainer
 --
 DataModel.xcdatamodeld
 DataModel.momd
 DataModel.sqlite
 
 **
 ManagedObjectModel : model
 PersistentStoreCoordinator : touche à la base de donnée directement.
 */
