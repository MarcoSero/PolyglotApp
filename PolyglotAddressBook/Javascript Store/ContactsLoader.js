// snippet from http://nshipster.com/javascriptcore/

var loadContactsFromJSON = function(jsonString) {
    var data = JSON.parse(jsonString);
    var contacts = [];
    for (i = 0; i < data.length; i++) {
        var contact = Contact.createWithFirstNameLastName(data[i].first, data[i].last);
        contact.imageUrlString = data[i].image_url;
        contact.phoneNumber = data[i].phone;
        contacts.push(contact);
    }
    return contacts;
}