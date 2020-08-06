//
//  TodoModel.swift
//  TodoList
//
//  Created by Eddy R on 05/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import Foundation

struct TodoModel{
    var id: String
    var title: String
    
  init (id: String, title:String) {
        self.id = id
        self.title = title
    }
}
