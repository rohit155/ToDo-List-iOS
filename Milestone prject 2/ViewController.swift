//
//  ViewController.swift
//  Milestone prject 2
//
//  Created by Rohit Jangid on 30/07/20.
//  Copyright © 2020 Rohit Jangid. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var list = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadList))
        
        title = "List Man"
    }
    
    //table view methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    //delete fuction in tableView
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //add new item to list

    @objc func addItem(){
        let ac = UIAlertController(title: "Enter Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.addAction(item)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func addAction(_ item: String){
        list.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    //clear tableView and array
    
    @objc func reloadList(){
        list.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
}

