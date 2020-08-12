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

  // MARK: - 🉑 Setting
  private var showClass: String {
    return String(describing: type(of: self))
  }
  @IBOutlet weak var tableView: UITableView!
  var tasksTasks : [NSManagedObject] = []
  
  // MARK: - ✅ Cycle Life
  override func viewDidLoad() {
    super.viewDidLoad()
    // fetch all the data in the table view
    fetcheCoredata()
    // edit button item provided by the table viewController
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  // MARK: - 🖐 Handle U
  @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
    print(" ▓ \(#line) ▓   (っ˘▽˘)っ ▓ \(showClass) ▓ ⊂(◕。◕⊂)  ( ˘ ³˘)♥ ▓ \(#function) ▓ ")
    // destination viewController, source TaskViewController,
    
    if let sourceViewController = sender.source as? TaskViewController, let _ = sourceViewController.task {
      // edit mode
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
        print("( ˘ ³˘)💙 ▓ \(#line)▓ /\(showClass).\(#function)/ Message : EDITION MODE")
        tableView.reloadRows(at: [selectedIndexPath], with: UITableView.RowAnimation.none)
      }
    } else {
        fetcheCoredata()
        tableView.reloadData()
    }
  }

  // MARK: - 💻 Own F
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    switch (segue.identifier ?? "") {
    case "AddItem":
      print("( ˘ ³˘)💙 ▓ \(#line)▓ /\(showClass).\(#function)/ Message : AddItem")
      
      
      break
    case "ShowDetail":
      guard let taskDetailsViewController = segue.destination as? TaskViewController else {
        fatalError("unexpected destination \(segue.destination)")
      }
      guard let selectedTaskCell = sender as? TaskTableViewCell else {
        fatalError("unexpected sender")
      }
      guard let indexPath = tableView.indexPath(for: selectedTaskCell) else {
        fatalError("the selected cell is not beign displayed by the table")
      }
      let selectedTask = tasksTasks[indexPath.row]
      taskDetailsViewController.task = selectedTask
    default:
      fatalError("Segue Identification is nil")
    }
  }
}

// MARK: - 💻 Own F
extension ViewController {
  // Core Data
  func saveCoreData(name: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      // appdelegate
      return
    }
    let managedContext = appDelegate.persistentContainer.viewContext // manageContext
    let task = TaskX1(context: managedContext) // set data
    task.setValue(name, forKey: "title")
    do {
      // commit
      try managedContext.save()
      tasksTasks.append(task)
      tableView.reloadData()
    } catch let error as NSError {
      print("could not save. \(error), \(error.userInfo)")
    }
  }
  func fetcheCoredata() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TaskX1")
    do {
      tasksTasks = try managedContext.fetch(fetchRequest)
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
      print(error, error.userInfo)
      fatalError("Deletion is not save in the manager object")
    }
    tableView.deleteRows(at: [index], with: UITableView.RowAnimation.fade)
  }
}

// MARK: - 👑 DELEGATE
// DataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasksTasks.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "TaskTableViewCell"
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell else {
      fatalError("the dequeued cell is not an instance of TaskTableViewCell")
    }
    
    //coredata
    let task = tasksTasks[indexPath.row]
    cell.nameLabel.text = task.value(forKey: "title") as? String
    return cell
  }
}
// tableViewDelegate
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

