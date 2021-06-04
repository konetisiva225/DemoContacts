//
//  ContactTests.swift
//  ContactDemo
//
//  Created by Jayant Tiwari on 01/06/21.
//  Copyright © 2021 Expleo. All rights reserved.
//

import UIKit

class ContactTests {
    
    func getAllContacts() -> [MyContacts] {
        
        var contactLists = [MyContacts]()
        
        contactLists.append(MyContacts(firstName: "Jayant", lastName: "Tiwari", phoneNumber: "9867608869" ?? ""))
        contactLists.append(MyContacts(firstName: "Dhayalu", lastName: "Ayyamperumal", phoneNumber: "87878787878" ?? ""))
        contactLists.append(MyContacts(firstName: "Gowtham", lastName: "Nallasivam", phoneNumber: "878787878" ?? ""))
        return contactLists
        
    }
    
    func getSingleContact(number : String) -> [MyContacts] {
        
        var contactList = [MyContacts]()
        contactList.append(MyContacts(firstName: "Jayant", lastName: "Tiwari", phoneNumber: "9867608869" ?? ""))
        return contactList
    }

}
