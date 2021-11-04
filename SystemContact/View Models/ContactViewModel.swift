import Foundation
import Contacts
import UIKit

struct ContactViewModel {
    var identifier: String = ""
    var photo: UIImage? = nil
    var firstName: String = ""
    var lastName: String = ""
    var middleName: String = ""
    var nickname: String = ""
    var jobTitle: String = ""
    var departmentName: String = ""
    var organizationName: String = ""
    var phoneNumbers: [PhoneViewModel] = []
    var emailAddresses: [EmailViewModel] = []
    var postalAddresses: [AddressViewModel] = []
    var urlAddresses: [UrlViewModel] = []
    var birthday: String = ""
    
    var fullName: String {
        middleName.isEmpty ? "\(firstName) \(lastName)" : "\(firstName) \(middleName) \(lastName)"
        
        // CNContactFormatter.string(from: self, style: .fullName)
    }
    
    init() {}
    
    init(contact: CNContact) {
        identifier = contact.identifier
        photo = contact.imageData == nil ? nil : UIImage(data: contact.imageData!)
        lastName = contact.familyName
        firstName = contact.givenName
        middleName = contact.middleName
        nickname = contact.nickname
        jobTitle = contact.jobTitle
        departmentName = contact.departmentName
        organizationName = contact.organizationName
        
        phoneNumbers = contact.phoneNumbers.map {
            PhoneViewModel(type: $0.label!, phone: $0.value.stringValue)
        }
        
        emailAddresses = contact.emailAddresses.map {
            EmailViewModel(type: $0.label!, email: $0.value as String)
        }
        
        postalAddresses = contact.postalAddresses.map {
            AddressViewModel(type: $0.label!, address: AddressDetailViewModel(address: $0.value))
        }
        
        urlAddresses = contact.urlAddresses.map {
            UrlViewModel(type: $0.label!, url: $0.value as String)
        }
        
        birthday = contact.birthday?.toString() ?? ""
    }
    
    func copyTo(mutableContact: CNMutableContact) {
        mutableContact.imageData = photo?.jpegData(compressionQuality: 1.0)
        mutableContact.givenName = firstName
        mutableContact.familyName = lastName
        mutableContact.middleName = middleName
        mutableContact.nickname = nickname
        mutableContact.jobTitle = jobTitle
        mutableContact.departmentName = departmentName
        mutableContact.organizationName = organizationName
        
        mutableContact.phoneNumbers = phoneNumbers.map {
            CNLabeledValue(
                label: $0.type,
                value: CNPhoneNumber(stringValue: $0.phone))
        }
        
        mutableContact.emailAddresses = emailAddresses.map {
            CNLabeledValue(
                label: $0.type,
                value: $0.email as NSString)
        }
        
        mutableContact.postalAddresses = postalAddresses.map {
            CNLabeledValue(
                label: $0.type,
                value: $0.address.toMutablePostalAddress())
        }
        
        mutableContact.urlAddresses = urlAddresses.map {
            CNLabeledValue(
                label: $0.type,
                value: $0.url as NSString)
        }
         
        mutableContact.birthday = birthday.toDateComponents()
    }
}

struct PhoneViewModel {
    let id = UUID()
    var type: String = ""
    var phone: String = ""
}

struct EmailViewModel {
    let id = UUID()
    var type: String = ""
    var email: String = ""
}

struct UrlViewModel {
    let id = UUID()
    var type: String = ""
    var url: String = ""
}
