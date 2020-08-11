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

class TaskViewController: UIViewController, UITextFieldDelegate {
  private var showClass: String {
    return String(describing: type(of: self))
  }
  
  // MARK: - Properties
  @IBOutlet weak var nameTextField: UITextField!
  
//  var task: Task?
  var task: NSManagedObject?
  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBOutlet weak var cancelButton: UIBarButtonItem!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    nameTextField.delegate = self
    
    // edit all the field if edit
    print("  💟 tasktask \(task) 💟")
    if let task = task {
      print(" ▓ \(#line) ▓   (っ˘▽˘)っ ▓ \(showClass) ▓ ⊂(◕。◕⊂)  ( ˘ ³˘)♥ ▓ \(#function) ▓ ")
      os_log("edit variableTask on text field and title navigation bar", log: OSLog.default, type: .debug)
//      navigationItem.title = task.name
//      nameTextField.text = task.name
      
    }
    
    updateSaveButtonState()
  }
  
  // MARK: - Navigation
  // Configure the destination view controller only whe the save button is pressed.
  // prepare(_ :,_: ) is called before any segue gets executed
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
//    task = Task(name: name)
  }
  
  public func textFieldDidBeginEditing(_ textField: UITextField) {
    print(" ▓ \(#line) ▓   (っ˘▽˘)っ ▓ \(showClass) ▓ ⊂(◕。◕⊂)  ( ˘ ³˘)♥ ▓ \(#function) ▓ ")
    saveButton.isEnabled = false
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    print(" ▓ \(#line) ▓   (っ˘▽˘)っ ▓ \(showClass) ▓ ⊂(◕。◕⊂)  ( ˘ ³˘)♥ ▓ \(#function) ▓ ")
    updateSaveButtonState()
    navigationItem.title = textField.text
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    print(" ▓ \(#line) ▓   (っ˘▽˘)っ ▓ \(showClass) ▓ ⊂(◕。◕⊂)  ( ˘ ³˘)♥ ▓ \(#function) ▓ ")
    textField.resignFirstResponder()
    return true
  }
  @IBAction func cancelAction(_ sender: UIBarButtonItem) {
    print(" ▓ \(#line) ▓   (っ˘▽˘)っ ▓ \(showClass) ▓ ⊂(◕。◕⊂)  ( ˘ ³˘)♥ ▓ \(#function) ▓ ")
    
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
  private func updateSaveButtonState() {
    print(" ▓ \(#line) ▓   (っ˘▽˘)っ ▓ \(showClass) ▓ ⊂(◕。◕⊂)  ( ˘ ³˘)♥ ▓ \(#function) ▓ ")
    // Disable the save button if the text fields is empty
    let text = nameTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
  }
}


