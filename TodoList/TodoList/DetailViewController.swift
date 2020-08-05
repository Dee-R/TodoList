//
//  DetailViewController.swift
//  TodoList
//
//  Created by Eddy R on 05/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//  BOSS know info
import UIKit
// Fonction principal + Delegate
protocol TapSaveDelegate{
  // actionTime + les info a passer à l'interner pour qu'il les manipule
  func didTapForSave(title:String)
}

class DetailViewController: UIViewController, UITextFieldDelegate {
  @IBOutlet private weak var titleTodo: UITextField!
  @IBOutlet private weak var buttonSave: UIButton!
  var delegateTapSave:TapSaveDelegate!
  
  override func viewDidLoad() {
    super.viewDidLoad()
     titleTodo.delegate = self
  }
  
  internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let userEnteredString = textField.text
    let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string) as NSString
    if newString != "" {
      showButton(false)
    } else {
      showButton(true)
    }
    return true
  }
  
  private func showButton(_ boolValue:Bool) {
    buttonSave.isHidden = boolValue
  }
  @IBAction func actionSave(_ sender: Any) {
//    navigationController?.popViewController(animated: true)
    delegateTapSave.didTapForSave(title: titleTodo.text!)
    dismiss(animated: true, completion: nil)
  }
}
