import Foundation
import Contacts

class ContactService {

    static let shared = ContactService()
    private let contactStore = CNContactStore()
    
    private init() {}
    
    func requestAccess(completion: @escaping (Result<Bool, ContactError>) -> Void) {
        contactStore.requestAccess(for: .contacts) { success, error in
            if success, error == nil {
                completion(.success(true))
                return
            }
            
            completion(.failure(.accessError))
        }
    }
    
    func fetchAll() throws -> [CNContact] {
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)
        var contacts = [CNContact]()
        
        try contactStore.enumerateContacts(with: request) { contact, stop in
            contacts.append(contact)
        }
        
        return contacts
    }
    
    func fetchOne(identifier: String) throws -> CNContact {
        let keys = [
            CNContactImageDataKey,
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactMiddleNameKey,
            CNContactNicknameKey,
            CNContactJobTitleKey,
            CNContactDepartmentNameKey,
            CNContactOrganizationNameKey,
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactPostalAddressesKey,
            CNContactUrlAddressesKey,
            CNContactBirthdayKey] as [CNKeyDescriptor]
        
        return try contactStore.unifiedContact(withIdentifier: identifier, keysToFetch: keys)
    }
    
    func add(contact: CNMutableContact) throws {
        let request = CNSaveRequest()
        request.add(contact, toContainerWithIdentifier: nil)
        try contactStore.execute(request)
    }
    
    func update(contact: CNMutableContact) throws {
        let request = CNSaveRequest()
        request.update(contact)
        try contactStore.execute(request)
    }
    
    func delete(contact: CNMutableContact) throws {
        let request = CNSaveRequest()
        request.delete(contact)
        try contactStore.execute(request)
    }
}

enum ContactError: Error {
    case accessError
}
