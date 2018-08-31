//
//  ViewController.swift
//  FileManageable
//
//  Created by Shabeer Hussain on 03/23/2017.
//  Copyright (c) 2017 Shabeer Hussain. All rights reserved.
//

import UIKit
import FileManageable

class ViewController: UIViewController, FileManageable {
    
    @IBOutlet weak var fileNameTextField: UITextField!
    @IBOutlet weak var fileExtensionTextField: UITextField!
    @IBOutlet weak var folderNameTextField: UITextField!
    @IBOutlet weak var filePathLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
}

//MARK:- Actions

extension ViewController {
    
    @IBAction func didTapSave(_ sender: AnyObject?) {
        
        guard
            let fileName = fileNameTextField.text,
            let fileExtension = fileExtensionTextField.text,
            let folderName = folderNameTextField.text
        else { return }
        
        let fileNameWithFolder = "\(folderName)/\(fileName)/\(fileExtension)"
        
        let filePath = "\(documentsDirectoryPath())/\(fileNameWithFolder)"
        
        if fileExists(at: filePath) {
            
            let alertViewController = UIAlertController(title: "Replace File?", message: "A file with the same name already exists at the path, tap save to replace it", preferredStyle: .alert)
            let saveAction = UIAlertAction(title: "Replace", style: .destructive, handler: { (action) in
                
                
            })
        }
        
        if createFolder(withName: folderName, in: documentsDirectoryURL()) {
            
            let answer = createFile(with: fileName, fileExtension: fileExtension, in: "\(documentsDirectoryPath())/\(folderName)")
            
        }
        
        
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        return cell
    }
}

