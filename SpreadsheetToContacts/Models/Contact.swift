//
//  Contact.swift
//  SpreadsheetToContacts
//
//  Created by Slobodan Marinkovikj on 5/25/19.
//  Copyright © 2019 Slobodan Marinkovikj. All rights reserved.
//

import Foundation
import RealmSwift

class Contact: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var email: String = ""
}
