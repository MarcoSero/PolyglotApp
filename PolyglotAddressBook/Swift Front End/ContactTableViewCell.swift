//
// Created by Marco Sero on 22/03/15.
// Copyright (c) 2015 Marco Sero. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneNumber: UILabel!
    @IBOutlet weak var contactImageView: UIImageView!
    var imageDownloadTask: NSURLSessionDataTask?
    
    func setup(#contact: Contact, session: NSURLSession, cache: ImageCache) {
        self.contactNameLabel.text = contact.fullName
        self.contactPhoneNumber.text = contact.phoneNumber
        
        let cacheKey = contact.fullName
        let cachedData = cache.imageForKey(cacheKey)
        if (cachedData != nil && cachedData?.length > 0) {
            self.contactImageView.image = UIImage(data: cachedData)
            return
        }
        self.imageDownloadTask = session.dataTaskWithURL(contact.imageURL, completionHandler: { data, response, error in
            if error != nil {
                return
            }
            let image = UIImage(data: data)
            cache.saveImageForKey(cacheKey, imageData: data)
            self.contactImageView.image = image
        })
        self.imageDownloadTask?.resume()
    }
    
    override func prepareForReuse() {
        self.imageDownloadTask?.cancel()
    }
}
