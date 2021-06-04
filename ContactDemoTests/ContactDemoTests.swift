//
//  ContactDemoTests.swift
//  ContactDemoTests
//
//  Created by Jayant Tiwari on 01/06/21.
//  Copyright © 2021 Expleo. All rights reserved.
//

import XCTest
@testable import ContactDemo

class ContactDemoTests: XCTestCase {
    
    
    func testSingleContact() {
        
        var contactTest = ContactTests()
        
        var contactList = contactTest.getSingleContact(number: "9787878")
        var number = contactList[0].phoneNumber
        
        var firstName = contactList[0].firstName
        
        var lastName = contactList[0].lastName
        
        var name = firstName + " " + lastName
        
        XCTAssertTrue(!name.isEmpty)
        XCTAssertTrue(number.count >= 9 && number.count <= 15)
        XCTAssertEqual(contactList.count, 1)
        XCTAssertTrue(contactList.count > 0)
        
        
    }
    
    func testAllContacts() {
        var contactTest = ContactTests()
        
        var contactLists = contactTest.getAllContacts()

        var number = contactLists[1].phoneNumber
               
               var firstName = contactLists[1].firstName
               
               var lastName = contactLists[1].lastName
               
               var name = firstName + " " + lastName
               
               XCTAssertTrue(!name.isEmpty)
               XCTAssertTrue(number.count >= 9 && number.count <= 15)
              // XCTAssertEqual(contactLists.count, 1)
              // XCTAssertEqual(contactLists.count, contactLists.count)
               XCTAssertTrue(contactLists.count > 1)
               
        
    }
    
    

}
