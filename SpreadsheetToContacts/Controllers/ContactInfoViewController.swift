//
//  ContactInfoViewController.swift
//  SpreadsheetToContacts
//
//  Created by Slobodan Marinkovikj on 5/26/19.
//  Copyright © 2019 Slobodan Marinkovikj. All rights reserved.
//

import UIKit
import RealmSwift

class ContactInfoViewController: UIViewController {

    @IBOutlet weak var contactInfoImage: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneTextField: UITextField!
    @IBOutlet weak var contactEmailTextField: UITextField!
    
    var contactName: String?
    var contactPhone: String?
    var contactEmail: String?
    var contactId: Int = 0
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contactNameLabel?.text = contactName
        contactPhoneTextField?.text = contactPhone
        contactEmailTextField?.text = contactEmail
        contactInfoImage.image = UIImage(named: "contactImage")
    }
    
    //MARK: Making calls
    @IBAction func contactPhoneButtonClicked(_ sender: Any) {
        if let url = URL(string: "tel://\(contactPhone!)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            print("Error calling")
        }
    }
    
    //TODO: Sending mail
    @IBAction func contactEmailButtonClicked(_ sender: Any) {
    }
    
    //MARK: Change the number or mail
    @IBAction func phoneTextFieldEditingDidEnd(_ sender: Any) {
        do {
            try realm.write{
                let contacts = realm.objects(Contact.self)
                let newContact = contacts[contactId]
                newContact.phone = contactPhoneTextField.text!
                realm.add(newContact)
            }
        } catch {
            print("error changing phone number")
        }
    }
    
    @IBAction func emailTextFieldEditingDidEnd(_ sender: Any) {
        do {
            try realm.write{
                let contacts = realm.objects(Contact.self)
                let newContact = contacts[contactId]
                newContact.email = contactEmailTextField.text!
                realm.add(newContact)
            }
        } catch {
            print("error changing email")
        }
    }
    
    
    
}
