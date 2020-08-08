//
//  Meal.swift
//  TodoList
//
//  Created by Eddy R on 07/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//
import Foundation
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
