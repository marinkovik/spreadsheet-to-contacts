//
//  ContactsTableViewController.swift
//  SpreadsheetToContacts
//
//  Created by Slobodan Marinkovikj on 5/25/19.
//  Copyright © 2019 Slobodan Marinkovikj. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MessageUI
import RealmSwift

class ContactsTableViewController: UITableViewController {
    
    let realm = try! Realm()

    var spreadsheetLink: String?{
        didSet{
            getApiResults()
        }
    }
    var contactPhoneNumber: String?
    var contactEmail: String?
    
    var contacts: Results<Contact>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getApiResults()
        loadContacts()
    }
    
    // How many rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts?.count ?? 1
    }
    
    
    // The look for the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactName = contacts?[indexPath.row].name
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForContact") as! ContactCell
        cell.contactNameLabel.text = contactName
        cell.contactImageView.image = UIImage(named: "contactImage")
        tableView.rowHeight = 50
        
        return cell
    }
    
    // What happen when click on the main cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToContactInfo", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ContactInfoViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.contactEmail = contacts?[indexPath.row].email
            destinationVC.contactName = contacts?[indexPath.row].name
            destinationVC.contactPhone = contacts?[indexPath.row].phone
            destinationVC.contactId = indexPath.row
        }
    }
    
    func getApiResults(){
        let spreadsheetId = spreadsheetLink?[39..<83]
        getContactsData(spreadsheetId: spreadsheetId!)
    }
    
    func getContactsData(spreadsheetId: String){
        Alamofire.request("https://api.sheetson.com/v1/sheets/Sheet1?spreadsheetId=\(spreadsheetId)", method: .get).responseJSON {
                response in
            if response.result.isSuccess {
                let spreadsheetJSON : JSON = JSON(response.result.value!)
                // Getting the actual data from our spreadsheet
                let allContacts = spreadsheetJSON["results"].array!
                //print(allContacts)
                for contact in allContacts {
                    print(contact["Name"].string!)
                    //self.conctactsName?.append(contact["Name"].string!)
                    let newContact = Contact()
                    newContact.email = contact["Mail"].string!
                    newContact.name = contact["Name"].string!
                    newContact.phone = contact["Phone Number"].string!
                    
                    //self.contacts.append(newContact)
                    
                    do {
                        try self.realm.write{
                            self.realm.add(newContact)
                        }
                    } catch {
                        print("Error saving to realm data")
                    }
                }
                // Location of the realm database
                //print(Realm.Configuration.defaultConfiguration.fileURL)
                
            } else {
                print("Something happened")
            }
        }
        contacts = realm.objects(Contact.self)
        tableView.reloadData()
    }
        
    @IBAction func deleteContactsButtonClicked(_ sender: Any) {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Error deleting items")
        }
        tableView.reloadData()
    }
    
    func loadContacts(){
        contacts = realm.objects(Contact.self)
        tableView.reloadData()
    }
    
    
}

// Adding method to String
extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
