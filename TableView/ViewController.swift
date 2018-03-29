//
//  ViewController.swift
//  TableView
//
//  Created by Leahy, William on 1/22/18.
//  Copyright © 2018 Leahy, William. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UITableViewController {
    
    let cellId = "cellId"
    var twoDimensionalNamesArray = [
        
    // MARK: uncomment below code to add more sections to the example tableView
    ExpandableNames.init(isExpanded: true, names: ["Amy", "Annie", "Alyssa"].map{ Contact(name: $0, isFavorited: false)}),
    ExpandableNames.init(isExpanded: true, names: ["Billy", "Bobby", "Boris"].map{ Contact(name: $0, isFavorited: false)}),
    ]

    var showIndexPath : Bool = false
    
    func isFavorited(sender: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
                let contact = twoDimensionalNamesArray[indexPath.section].names[indexPath.row]
                let isContactFavorited = contact.isFavorited
                twoDimensionalNamesArray[indexPath.section].names[indexPath.row].isFavorited = !isContactFavorited
                tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @objc func toggleIndex() {
        var indexPathToReload = [IndexPath]()
        
        // section # returns array of names > also checks if section content is not 0 to avoid crash during animation
        for indice in twoDimensionalNamesArray.indices {
            let section = twoDimensionalNamesArray[indice]
            if section.isExpanded == true {
                for row in section.names.indices {
                    let indexPath = IndexPath(row: row, section: indice)
                    indexPathToReload.append(indexPath)
                }
            }
        }
        
        // evaluate animations style
        showIndexPath = !showIndexPath
        let animationStyle : UITableViewRowAnimation = showIndexPath ? .right : .left
        tableView.reloadRows(at: indexPathToReload, with: animationStyle)
        
        navigationItem.rightBarButtonItem?.title = showIndexPath ? "Hide Index" : "Show Index"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Index", style: .plain, target: self, action: #selector(toggleIndex))
        
        // large content navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // register cell
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    // MARK: tableView methods
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        
        // MARK : uncomment to grab set section to alphabetical letter of that names array
        // let letter = twoDimensionalNamesArray[section].names[0].name.first
        
        // set button styling
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.tag = section
        
        // button tap action
        button.addTarget(self, action: #selector(handleOpenClose), for: .touchUpInside)
        return button
    }
    
    @objc func handleOpenClose(with button: UIButton ) {
        let section = button.tag
        let isExpanded = twoDimensionalNamesArray[section].isExpanded
        var indexPaths = [IndexPath]()
        for row in twoDimensionalNamesArray[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        twoDimensionalNamesArray[section].isExpanded = !isExpanded
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
           tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalNamesArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalNamesArray[section].isExpanded {
            return 0
        }
        return twoDimensionalNamesArray[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactCell
        
        cell.cellDelegate = self
        
        // evaluate if show
        let contact = twoDimensionalNamesArray[indexPath.section].names[indexPath.row]
        cell.textLabel?.text = contact.name
        cell.accessoryView?.tintColor = contact.isFavorited ? .blue : .gray
        if showIndexPath == true {
            cell.textLabel?.text = "\(contact.name) -- \(indexPath.section), \(indexPath.row)"
        }
        return cell
    }
}


