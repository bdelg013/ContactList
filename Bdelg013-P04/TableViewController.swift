// PROGRAMMER:  Brian Delgado
// PANTHERID:   6058871
// CLASS:       COP 465501
// INSTRUCTOR:  Steve Luis ECS 282
// ASSIGNMENT:  Program #4
// DUE:         Saturday 10/28/18
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var addButton: UIButton!
    var detailViewController = DetailViewController()
    let contactDb = ContactDatabase.shared
    var currentRow: Int = 0
    var contact: Contact?
    var editMode: Bool = false
    var addingMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let tableInsets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = tableInsets
        tableView.scrollIndicatorInsets = tableInsets
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //returns table count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(contactDb.getContactCount())
        return contactDb.getContactCount()
    }
    
    //Deqeues cells and initializes row title
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        contactDb.updatePosition(location: indexPath.row)
        cell.textLabel?.text = contactDb.getContactName()
        return cell
    }
    
    //Removes table row in editing mode
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //If table is set to delete a row
        if(editingStyle == .delete) {
            //Model class must first delete corresponding index
            contactDb.removeContact(indexPath.row)
            //Then table does the same thing
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //determines if row has been selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRow = indexPath.row
        contactDb.position = indexPath.row
    }

    func setContact(contact: Contact) {
        self.contact = contact
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        let detailViewController = segue.destination as? DetailViewController
        detailViewController?.contact = contactDb.getContactAt(location: currentRow)
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            //makes a new/clear contact, with date of birth starting at current date
            detailViewController?.contact = Contact(firstName: "", lastName: "", email: "", phone: "", dob: Date(timeIntervalSinceNow: 0), picture: nil)
            //turn on AddItem mode
            detailViewController?.addMode = true
        case "ShowDetail":
            //make the detail view contact the currently clicked contact,to fill detail view
            detailViewController?.contact = contactDb.getContactAt(location: currentRow )
            // turn on "edit" mode
            detailViewController?.editMode = true
        default:
            print ("Error")
        }
        detailViewController?.currentRow = self.currentRow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //reset flags
        editMode = false
        addingMode = false
        //reload table everytime it appears
        tableView.reloadData()
    }
        
    //to enable editing/deleting of contacts
    @IBAction func toggleEditMode(_ sender: UIButton) {
        
        if(isEditing) {
            //re-enable button
            addButton.isUserInteractionEnabled = true
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        }
        else {
            //disable edit button while picking contact to delete
            addButton.isUserInteractionEnabled = false
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
}


