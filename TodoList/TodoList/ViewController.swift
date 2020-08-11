//
//  ViewController.swift
//  TodoList
//
//  Created by Eddy R on 05/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
// inter acting with info

import UIKit
import os.log
import CoreData


class ViewController:UIViewController {
  private var showClass: String {
    return String(describing: type(of: self))
  }
  
  
  @IBOutlet weak var tableView: UITableView!
  var tasks = [Task]()
  var tasksTasks : [NSManagedObject] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // fetch all the data in the table view
    fetcheCoredata()
      
    
    //loadSampleMeals()
    
    // edit button item provided by the table viewController
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  // MARK: - Private methods
  private func loadSampleMeals() {
    guard let task1 = Task(name: "Clean the room") else {
      fatalError("Unable to instantiate task1")
    }
    guard let task2 = Task(name: "Buy some food") else {
      fatalError("Unable to instantiate task2")
    }
    tasks += [task1, task2]
  }
  
  // MARK: - Actions
  @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
    
    
    if let sourceViewController = sender.source as? TaskViewController, let task = sourceViewController.task {
      // edit mode
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
        os_log("edit mode", log: OSLog.default, type: .debug)
        print("( ˘ ³˘)💙 ▓ \(#line) ▓ task from TaskViewController.task", task.value(forKey: "title"))

//        tasks[selectedIndexPath.row] = task
        tableView.reloadRows(at: [selectedIndexPath], with: UITableView.RowAnimation.none)
        
      } else {
        // Add mode
        os_log("add mode", log: OSLog.default, type: .debug)
        _ = IndexPath(row: tasksTasks.count, section: 0)
        
        // here
//        insert(task.name)
//        tasks.append(task)
        
//        tableView.insertRows(at: [newIndexPath], with: UITableView.RowAnimation.automatic)
//        self.saveCoreData(name: task.name ?? "")
        
        
        // SAVE IN CORE DATA
        
      }
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    switch (segue.identifier ?? "") {
    case "AddItem":
      print("add")
      os_log("button '+' clicked : AddItem", log: OSLog.default, type: .debug)
      
    case "ShowDetail":
//      os_log("line 87 ShowDetail from viewcontroller to TaskViewController", log: OSLog.default, type: .debug)
////      os_log("row clicked: ShowDetail ", log: OSLog.default, type: .debug)
      guard let taskDetailsViewController = segue.destination as? TaskViewController else {
        fatalError("unexpected destination \(segue.destination)")
      }
////
      guard let selectedTaskCell = sender as? TaskTableViewCell else {
        fatalError("unexpected sender")
      }
//
      print("( ˘ ³˘)💙 ▓ \(#line) ▓ sender expediteur : \(sender)")

      guard let indexPath = tableView.indexPath(for: selectedTaskCell) else {
        fatalError("the selected cell is not beign displayed by the table")
      }
//
      
//
////
//      let selectedTask = tasks[indexPath.row]
//      taskDetailsViewController.task = selectedTask // send all information about the row on edit operation to TaskViewController in the var 'task'.
      
      let selectedTask = tasksTasks[indexPath.row]
      taskDetailsViewController.task = selectedTask
      // STOP HERE 🚦🌁🏝☀️🏖🐬🏝🏞🏜🚦
      
//      updateCoreData(at: indexPath)
    
    default:
      fatalError("Segue Identification is nil")
    }
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return tasks.count
    return tasksTasks.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "TaskTableViewCell"
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell else {
      fatalError("the dequeued cell is not an instance of TaskTableViewCell")
    }
    // fetch the appropriate
//    let task = tasks[indexPath.row]
//    cell.nameLabel.text = task.name
//    return cell
    
    //coredata
    let task = tasksTasks[indexPath.row]
    cell.nameLabel.text = task.value(forKey: "title") as? String
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // Delete the row
//      tasks.remove(at: indexPath.row)
//      tableView.deleteRows(at: [indexPath], with: .fade)
      // STOP HERE 🚦🌁🏝☀️🏖🐬🏝🏞🏜🚦

      
      deleteCoreData(at: indexPath)
      
      
      
     
    } else if editingStyle == .insert {
      // create a new instance of the appropiate class, insert it into the array and ad a new row to the table.
      
    }
  }
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
}

extension ViewController {
  // Core Data
  func saveCoreData(name: String) {
    print(" ▓ \(#line) ▓   (っ˘▽˘)っ ▓ \(showClass) ▓ ⊂(◕。◕⊂)  ( ˘ ³˘)♥ ▓ \(#function) ▓ ")
    // appdelegate
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    // manageContext
    let managedContext = appDelegate.persistentContainer.viewContext
    
//    // entities
//    let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: managedContext)!
//    // manageur d'object ( entities, context
//    let task = NSManagedObject(entity: entity, insertInto: managedContext)
    
    // set data
    let task = TaskX1(context: managedContext)
    task.setValue(name, forKey: "title")
    
    // commit di try catch
    do {
      try managedContext.save()
      tasksTasks.append(task)
      
      print("  💟🐝\(#line)💟▓▒░ task----- ░▒▓💟",task,"💟")
      tableView.reloadData()
      
      
    } catch let error as NSError {
      print("could not save. \(error), \(error.userInfo)")
    }
    os_log("end save in saveCoreData line 172", log: OSLog.default, type: .debug)
  }
  func fetcheCoredata() {
    // appdelegate
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    // manager context
    let managedContext = appDelegate.persistentContainer.viewContext
    
    //prepare request to fetch
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TaskX1")
    
    do {
      tasksTasks = try managedContext.fetch(fetchRequest)
      
//      print("  💟🐝\(#line)💟▓▒░ tasksTasks ░▒▓💟",tasksTasks.count,"💟")
//      print("  💟🐝\(#line)💟▓▒░ tasksTasks ░▒▓💟",tasksTasks,"💟")
      
    } catch let error as NSError {
      print("could not fetch \(error) , \(error.userInfo)")
    }
    
  }
  func insertCoredata(title: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    let managedObjectContext = appDelegate.persistentContainer.viewContext //managedObjectContext
    let task = TaskX1(context: managedObjectContext) // object himself
    task.setValue(title, forKey: "title") // setting
    do {
      try managedObjectContext.save()  // save
      tasksTasks.append(task) // stiock in the array
      tableView.reloadData() //
    } catch let error as NSError {
      print("could not save \(error), \(error.userInfo)")
    }
    
  }
  func deleteCoreData(at index: IndexPath){
    
    //CoreData Delete
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    let managedContext = appDelegate.persistentContainer.viewContext // managedObjectContext
    do {
      managedContext.delete(tasksTasks[index.row])
      tasksTasks.remove(at: index.row)
      
      try managedContext.save()
    } catch let error as NSError {
      print(error)
      print(error.userInfo)
      fatalError("Deletion is not save in the manager object")
    }
    tableView.deleteRows(at: [index], with: UITableView.RowAnimation.fade)
    
    
  }
//  func updateCoreData(at index: IndexPath) {
//    let selectedTask = tasksTasks[index.row]
//  }
  
  
}
