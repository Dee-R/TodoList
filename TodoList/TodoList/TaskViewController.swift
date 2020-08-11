//
//  TaskViewController.swift
//  TodoList
//
//  Created by Eddy R on 07/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import UIKit
import CoreData
import os.log

class TaskViewController: UIViewController {
  
  // MARK: - 🉑 Setting
  private var showClass: String {
    return String(describing: type(of: self))
  }
  @IBOutlet weak var nameTextField: UITextField!
  var task: NSManagedObject? // Model
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  
  // MARK: - ✅ Cycle Life
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    nameTextField.delegate = self
    
    print("( ˘ ³˘)💙 ▓ \(#line) ▓ verifie task quand add  new entry : \(task)")
    
    // edit all the field if edit
    if let task = task {
      //      navigationItem.title = task.name
      //      nameTextField.text = task.name
      navigationItem.title = task.value(forKey: "title") as? String
      nameTextField.text = task.value(forKey: "title") as? String
    }
    
    // action state for textfield
    updateSaveButtonState()
  }
  
  
  // MARK: - Navigation
  // Configure the destination view controller only whe the save button is pressed.
  // prepare(_ :,_: ) is called before any segue gets executed
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    print(" ▓ \(#line) ▓   (っ˘▽˘)っ ▓ \(showClass) ▓ ⊂(◕。◕⊂)  ( ˘ ³˘)♥ ▓ \(#function) ▓ ")
    // verify is sender is a button (sender as? UIBarButtonItem)
    // check if the object referenced is same with saveButton object (button === saveButton)
    guard let button = sender as? UIBarButtonItem, button === saveButton else {
      os_log("the save button was not pressed, cancelling", log: OSLog.default, type: .debug)
      return
    }
    
    let name = nameTextField.text ?? ""
    
    if task == nil {
      //** Add Mode mode
      print("( ˘ ³˘)💙 ▓ \(#line)▓ /\(showClass).\(#function)/ Message : task nil = \(task)")
      insertCoredata(title: name)
      

    } else {
      //** Edition mode
      // nil coalescing value is used to return the value of an optional if it is nil
//      let name = nameTextField.text ?? ""
      // set the task to be passed to ViewController after the unwind segue.
      task?.setValue(name, forKey: "title")
      saveCoreData(object: task)
    }
  }
  
  // MARK: - 🖐 Handle U
  @IBAction func cancelAction(_ sender: UIBarButtonItem) {
    // depending on style of presentation ( modal or push presentation , this vie< controller needs to be dismessed in two different ways
    let isPressentingInAddTaskMode = presentingViewController is UINavigationController
    
    if (isPressentingInAddTaskMode) {
      dismiss(animated: true, completion: nil)
    } else if let owningNavigationController = navigationController {
      owningNavigationController.popViewController(animated: true)
    } else {
      fatalError("the taskViewController is not inside a navigation controller")
    }
  }
  
  // MARK: - 💻 Own F
  private func updateSaveButtonState() {
    // Disable the save button if the text fields is empty
    let text = nameTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
  }
}

// CoreData
extension TaskViewController {
  func saveCoreData(object:NSManagedObject?) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return } // appDele
    let context  = appDelegate.persistentContainer.viewContext //// manageContext
    
    guard let obj = object  else {
//      fatalError("object:NSManagedObject is nil")
      print("  💟🐝\(#line)💟▓▒░ task ░▒▓💟",task,"💟")
      return
    }
    
    do {
      try context.save()
    } catch let error as NSError {
      print(error, error.userInfo)
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
    } catch let error as NSError {
      print("could not save \(error), \(error.userInfo)")
    }
  }
}

// MARK: - 👑 DELEGATE
// Delegation TextField
extension TaskViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    saveButton.isEnabled = false
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    updateSaveButtonState()
    navigationItem.title = textField.text
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}



