// PROGRAMMER:  Brian Delgado
// PANTHERID:   6058871
// CLASS:       COP 465501
// INSTRUCTOR:  Steve Luis ECS 282
// ASSIGNMENT:  Program #4
// DUE:         Saturday 10/28/18
//

import Foundation
import UIKit

struct Contact {
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var dob: Date //Date of Birth
    var picture: UIImage! //picture
}

class ContactDatabase {
    
    var contactStorage = [Contact]()
    var position:Int = 0
    
    static let shared = ContactDatabase()
    
    init() {
        //initialize 10 contacts
        let contact1 = Contact(firstName: "Brian", lastName: "Delgado", email: "Briandel@gmail.com", phone: "786-456-7896", dob: Date(timeIntervalSinceNow: -9999999), picture: nil)
        let contact2 = Contact(firstName: "James", lastName: "Jackson", email: "James@gmail.com", phone: "786-456-7896", dob: Date(timeIntervalSinceNow: -99999998), picture: nil)
        let contact3 = Contact(firstName: "Monica", lastName: "Delgado", email: "Monica@gmail.com", phone: "786-456-7896", dob: Date(timeIntervalSinceNow: -99999997), picture: nil)
        let contact4 = Contact(firstName: "Kaitlyn", lastName: "Menendez", email: "Kaitlyn@gmail.com", phone: "786-456-7896", dob: Date(timeIntervalSinceNow: -99999999), picture: nil)
        let contact5 = Contact(firstName: "Jorge", lastName: "Gomez", email: "Jorge@gmail.com", phone: "786-456-7896", dob: Date(timeIntervalSinceNow: -99999799), picture: nil)
        let contact6 = Contact(firstName: "Anthony", lastName: "Gonzalez", email: "Anthony@gmail.com", phone: "786-456-7896", dob: Date(timeIntervalSinceNow: -99999499), picture: nil)
        let contact7 = Contact(firstName: "Daniel", lastName: "Smith", email: "Daniel@gmail.com", phone: "786-456-7896", dob: Date(timeIntervalSinceNow: -99995999), picture: nil)
        let contact8 = Contact(firstName: "Alex", lastName: "White", email: "Alex@gmail.com", phone: "786-456-7896", dob: Date(timeIntervalSinceNow: -99995999), picture: nil)
        let contact9 = Contact(firstName: "Joseph", lastName: "Wimpey", email: "Joseph@gmail.com", phone: "786-456-7896", dob: Date(timeIntervalSinceNow: -99991999), picture: nil)
        let contact10 = Contact(firstName: "Imara", lastName: "Abella", email: "Imara@gmail.com", phone: "786-456-7896", dob: Date(timeIntervalSinceNow: -999945999), picture: nil)
        //add contacts to database
        contactStorage.append(contact1)
        contactStorage.append(contact2)
        contactStorage.append(contact3)
        contactStorage.append(contact4)
        contactStorage.append(contact5)
        contactStorage.append(contact6)
        contactStorage.append(contact7)
        contactStorage.append(contact8)
        contactStorage.append(contact9)
        contactStorage.append(contact10)
        //sort array; alphabetically
        contactStorage.sort(by: {$0.lastName < $1.lastName})
    }
    
    //Returns random number at location indicated by the row index
    func getContactAt(location loc: Int) -> Contact {
        position = loc
        return contactStorage[loc]
    }
    
    //Inserts number from initial location to new destination
    func moveContact(_ source: Int, _ destination: Int) {
        //If the source and destination are the same, nothing happens
        if(source == destination)
        {
            return
        }
        
        let fromItem = contactStorage[source];
        
        contactStorage.remove(at: source)
        
        contactStorage.insert(fromItem, at: destination)
    }
    
    //Inserts a new randomly generated number to the beginning of the array
    func addContact(contact: Contact) {
        let newContact = Contact(firstName: contact.firstName, lastName: contact.lastName, email: contact.email, phone: contact.phone, dob: contact.dob, picture: nil)
        
        contactStorage.append(newContact)
        //sort after adding contact
        contactStorage.sort(by: {$0.lastName < $1.lastName})
    }
    
    //Removes an integer at the given index
    func removeContact(_ index: Int)
    {
        contactStorage.remove(at: index)
    }
    
    //Returns the size of the array
    func getContactCount() -> Int
    {
        return contactStorage.count
    }
    
    func getContactName() -> String {
        return contactStorage[position].firstName + " " + contactStorage[position].lastName
    }
    
    func updatePosition(location loc: Int) {
        position = loc
    }
}
