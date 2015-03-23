var loadContactsFromJSON = function(jsonString) {
    var data = JSON.parse(jsonString);
    var contacts = [];
    for (i = 0; i < data.length; i++) {
        var contact = Contact.createWithFirstNameLastNameImageUrl(data[i].first, data[i].last, data[i].image_url);
        contacts.push(contact);
    }
    return contacts;
}