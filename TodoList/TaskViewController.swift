//
//  TaskViewController.swift
//  TodoList
//
//  Created by Eddy R on 07/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import UIKit
import os.log

class TaskViewController: UIViewController {
  
  // MARK: - Properties
  @IBOutlet weak var nameTextField: UITextField!
  
  var task: Task?
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  // MARK: - Navigation
  // Configure the destination view controller only whe the save button is pressed.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    // verify is sender is a button (sender as? UIBarButtonItem)
    // check if the object referenced is same with saveButton object (button === saveButton)
    guard let button = sender as? UIBarButtonItem, button === saveButton else {
      os_log("the save button was not pressed, cancelling", log: OSLog.default, type: .debug)
      return
    }
    
    // nil coalescing value is used to return the value of an optional if it is nil
    let name = nameTextField.text ?? ""
    
    // set the task to be passed to ViewController after the unwind segue.
    task = Task(name: name)
  }
}
