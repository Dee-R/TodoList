//
//  TaskX1+CoreDataProperties.swift
//  TodoList
//
//  Created by Eddy R on 10/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//
//

import Foundation
import CoreData


extension TaskX1 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskX1> {
        return NSFetchRequest<TaskX1>(entityName: "TaskX1")
    }

    @NSManaged public var title: String?

}
