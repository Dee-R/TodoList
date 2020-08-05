//
//  ViewController.swift
//  TodoList
//
//  Created by Eddy R on 05/08/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
// inter acting with info

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var todoList = ["buy Food", "clean the room"]
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self //ViewController est la datasource de tableview
  }
  
  
  @IBAction func actionAddTodo(_ sender: Any) {
    print("  💟 coco 💟")
    let viewControllerDestination = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    viewControllerDestination.navigationController?.navigationBar.topItem?.title = "toto"
    viewControllerDestination.delegateTapSave = self
    
    present(viewControllerDestination, animated: true, completion: nil)
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = todoList[indexPath.row]
    return cell
  }
}

extension ViewController: TapSaveDelegate {
  func didTapForSave(title:String) {
    todoList.append(title)
    tableView.reloadData()
    print("didTapForSave")
  }
}
