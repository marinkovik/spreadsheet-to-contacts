//
//  ViewController.swift
//  SpreadsheetToContacts
//
//  Created by Slobodan Marinkovikj on 5/25/19.
//  Copyright © 2019 Slobodan Marinkovikj. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var textFieldForSource: UITextField!
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func goToContactButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "goToContactSegue", sender: nil)
    }
    
    // What happend before performing segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToContactSegue"{
            if textFieldForSource.text?.count != 0 {
                let destinationVC = segue.destination as! ContactsTableViewController
                destinationVC.spreadsheetLink = textFieldForSource.text!
            }
        }
    }
}

