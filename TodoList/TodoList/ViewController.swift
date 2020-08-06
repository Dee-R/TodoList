//
//  ViewController.swift
//  TodoList
//
//  Created by Eddy R on 05/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
// inter acting with info
 
import UIKit

struct ModelT {
  let title:String!
//  let id:String!
//  let uuid = NSUUID().uuidString
  init(title:String) {
//    self.id = uuid
    self.title = title
  }
}

class ViewController: UIViewController, UITableViewDataSource, TapSaveDelegate {
  func didTapForSave(title: String) {
    todoList.append(ModelT(title: title))
    tableView.reloadData()
  }
  
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
  @IBAction func actionAdd(_ sender: Any) {
    let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    print(vc)
    vc.delegateTapSave = self
    present(vc, animated: true, completion: nil)
  }
  
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
