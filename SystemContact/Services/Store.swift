import Foundation
import Contacts

class Store: ViewModel {
    @Published var contacts: [ContactNameViewModel] = []
    @Published var hasPermission = false
    
    static let shared = Store()
    
    private override init() {
        super.init()
        
        ContactService.shared.requestAccess { result in
            switch result {
            case .success(_):
                self.hasPermission = true
                self.fetchAll()
                
            case .failure(_):
                self.hasPermission = false
                self.errorMessage = "Failed to access Contacts"
            }
        }
    }
    
    @discardableResult
    func fetchAll() -> Bool {
        do {
            let cnContacts = try ContactService.shared.fetchAll()
            contacts = cnContacts.map(ContactNameViewModel.init)
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
        
        return true
    }
    
    func fetchOne(identifier: String) -> ContactViewModel? {
        do {
            let cnContact = try ContactService.shared.fetchOne(identifier: identifier)
            return ContactViewModel(contact: cnContact)
        }
        catch {
            errorMessage = error.localizedDescription
            return nil
        }
    }
    
    @discardableResult
    func save(contact: ContactViewModel) -> Bool {
        if contact.identifier.isEmpty {
            return create(contact: contact)
        }
        
        return update(contact: contact)
    }
    
    private func create(contact: ContactViewModel) -> Bool {
        let mutableContact = CNMutableContact()
        contact.copyTo(mutableContact: mutableContact)
        
        do {
            try ContactService.shared.add(contact: mutableContact)
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
        
        return fetchAll()
    }
    
    private func update(contact: ContactViewModel) -> Bool {
        var cnContact: CNContact
        
        do {
            cnContact = try ContactService.shared.fetchOne(identifier: contact.identifier)
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
        
        let mutableContact = cnContact.mutableCopy() as! CNMutableContact
        contact.copyTo(mutableContact: mutableContact)
        
        do {
            try ContactService.shared.update(contact: mutableContact)
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
        
        return fetchAll()
    }
    
    @discardableResult
    func delete(identifier: String) -> Bool {
        do {
            let cnContact = try ContactService.shared.fetchOne(identifier: identifier)
            let mutableContact = cnContact.mutableCopy() as! CNMutableContact
            
            try ContactService.shared.delete(contact: mutableContact)
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
        
        return fetchAll()
    }
    
    @discardableResult
    func deleteAll(identifiers: [String]) -> Bool {
        do {
            for identifier in identifiers {
                let cnContact = try ContactService.shared.fetchOne(identifier: identifier)
                let mutableContact = cnContact.mutableCopy() as! CNMutableContact
                
                try ContactService.shared.delete(contact: mutableContact)
            }
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
        
        return fetchAll()
    }
}
