//
//  ViewController.swift
//  TodoList
//
//  Created by Eddy R on 05/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
// inter acting with info
 
import UIKit

// Model
struct ModelT {
  let title:String!
//  let id:String!
//  let uuid = NSUUID().uuidString
  init(title:String) {
//    self.id = uuid
    self.title = title
  }
}

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  var todoList = [
    ModelT(title: "One"),
    ModelT(title: "Two"),
    ModelT(title: "Three")
  ]
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
  }
  
  // Action
  @IBAction func actionAdd(_ sender: Any) {
    let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    print(vc)
    vc.delegateTapSave = self
    present(vc, animated: true, completion: nil)
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoList.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = todoList[indexPath.row].title
    print("cell", cell)
    return cell
  }
}

extension ViewController: TapSaveDelegate {
  func didTapForSave(title: String) {
    todoList.append(ModelT(title: title))
    tableView.reloadData()
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == UITableViewCell.EditingStyle.delete) {
      //
      print("██░░░ -- L\(#line) ⭐️⭐️ delete ⭐️⭐️\n")
      todoList.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
//      todos.removeAtIndex(indexPath.row)
//      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
  }
}
