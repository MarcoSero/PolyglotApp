//
//  ViewController.swift
//  PolyglotAddressBook
//
//  Created by Marco Sero on 20/03/2015.
//  Copyright (c) 2015 Marco Sero. All rights reserved.
//

import UIKit

extension NSFileManager {
    class func cachesDir() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true) as [String]
        return paths[0]
    }
}

class ContactsTableViewController: UITableViewController, UITableViewDataSource {

    var contacts: Array<AnyObject> = []
    let jsonImporter : JSONDataImporter = JSONDataImporter()
    let CellIdentifier = "ContactCellIdentifier"
    let urlSession = NSURLSession.sharedSession()
    
    var imageCache : ImageCache! {
        get {
            let cachePath = NSFileManager.cachesDir().stringByAppendingPathComponent("image_cache");
            NSFileManager.defaultManager().createDirectoryAtPath(cachePath, withIntermediateDirectories: false, attributes: nil, error: nil)
            return ImageCacheCppProxy.createWithPath(cachePath)
        }
    }
    
    // MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadContacts()
    }
    
    private func loadContacts() {
        jsonImporter.loadContactsFromDisk {
            self.contacts = $0
            self.tableView.reloadData()
        }
    }
    
    // MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ContactTableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as ContactTableViewCell
        let contact: Contact = contacts[indexPath.row] as Contact
        cell.setup(contact: contact, session: urlSession, cache: self.imageCache)
        return cell
    }

}

