//
//  ViewController.swift
//  TodoList
//
//  Created by Eddy R on 05/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
// inter acting with info

import UIKit
import os.log

class ViewController:UIViewController {
  @IBOutlet weak var tableView: UITableView!
  var tasks = [Task]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadSampleMeals()
    
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
    
    // edit mode
    
    
    if let sourceViewController = sender.source as? TaskViewController, let task = sourceViewController.task {
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
      //      print("  💟🐝\(#line)💟▓▒░ selectedIndexPath ░▒▓💟",selectedIndexPath.row,"💟")
        tasks[selectedIndexPath.row] = task
        tableView.reloadRows(at: [selectedIndexPath], with: UITableView.RowAnimation.none)
      } else {
          let newIndexPath = IndexPath(row: tasks.count, section: 0)
          tasks.append(task)
          tableView.insertRows(at: [newIndexPath], with: UITableView.RowAnimation.automatic)
      }
      
      
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    switch (segue.identifier ?? "") {
    case "AddItem":
      os_log("button '+' clicked : AddItem", log: OSLog.default, type: .debug)
    case "ShowDetail":
      os_log("row clicked: ShowDetail ", log: OSLog.default, type: .debug)
      guard let taskDetailsViewController = segue.destination as? TaskViewController else {
        fatalError("unexpected destination \(segue.destination)")
      }
      
      guard let selectedTaskCell = sender as? TaskTableViewCell else {
        fatalError("unexpected sender")
      }
      
      guard let indexPath = tableView.indexPath(for: selectedTaskCell) else {
        fatalError("the selected cell is not beign displayed by the table")
      }
      
      let selectedTask = tasks[indexPath.row]
      taskDetailsViewController.task = selectedTask // send all information about the row on edit operation to TaskViewController in the var 'task'.
    
    default:
      fatalError("Segue Identification is nil")
    }
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "TaskTableViewCell"
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell else {
      fatalError("the dequeued cell is not an instance of TaskTableViewCell")
    }
    // fetch the appropriate
    let task = tasks[indexPath.row]
    cell.nameLabel.text = task.name
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // Delete the row
      tasks.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
     
    } else if editingStyle == .insert {
      // create a new instance of the appropiate class, insert it into the array and ad a new row to the table.
      
    }
  }
  
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
}
