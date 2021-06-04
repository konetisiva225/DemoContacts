//
//  ContactController.swift
//  ContactDemo
//
//  Created by Jayant Tiwari on 01/06/21.
//  Copyright © 2021 Expleo. All rights reserved.
//

import UIKit
import Contacts

class ContactController: UIViewController {
    
    @IBOutlet weak var tblContacts: UITableView!
    var contactLists = [MyContacts]()
//    var contactTest = ContactTests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblContacts.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(contactLists.count > 0) {
            tblContacts.reloadData()
        } else {
           // contactLists = fetchSingleContact(number: "8869")
            contactLists = fetchAllContact()
        }
    }
    
}

extension ContactController : UITableViewDelegate, UITableViewDataSource {
    
    func fetchSingleContact(number : String) -> [MyContacts] {
        
        // 1.
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                // 2.
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    // 3.
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        
                        if(contact.phoneNumbers.first?.value.stringValue.contains(number) ?? false) {
                            self.contactLists.append(MyContacts(firstName: contact.givenName, lastName: contact.familyName, phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? ""))
                        }
                    })
                    
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
                
                DispatchQueue.main.async {

                    self.tblContacts.reloadData()
                }
            } else {
                print("access denied")
            }
        }
        
        //contactList.append(MyContacts(firstName: "Jayant", lastName: "Tiwari", phoneNumber: "9867608869" ?? ""))
        return contactLists
    }
    
    func fetchAllContact() -> [MyContacts] {
        
        // 1.
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                // 2.
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    // 3.
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        self.contactLists.append(MyContacts(firstName: contact.givenName, lastName: contact.familyName, phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? ""))
                    })
                    
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
                
                DispatchQueue.main.async {
                    
                    self.tblContacts.reloadData()
                }
            } else {
                print("access denied")
            }
        }
        
        //contactList.append(MyContacts(firstName: "Jayant", lastName: "Tiwari", phoneNumber: "9867608869" ?? ""))
        return contactLists
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact") as! ContactCell
        
        cell.lblName?.text = contactLists[indexPath.row].firstName + " " + contactLists[indexPath.row].lastName
        cell.lblNumber?.text = contactLists[indexPath.row].phoneNumber
        
        return cell
    }
}
