import Foundation
import Contacts

struct ContactNameViewModel {
    let identifier: String
    var firstName: String
    var lastName: String
    
    init(contact: CNContact) {
        identifier = contact.identifier
        lastName = contact.familyName
        firstName = contact.givenName
    }
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
