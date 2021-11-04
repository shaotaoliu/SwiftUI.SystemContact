import SwiftUI

struct ContactView: View {
    @State private var showEditView = false
    @State private var contact: ContactViewModel
    var identifier: String
    
    init(identifier: String) {
        contact = Store.shared.fetchOne(identifier: identifier)!
        self.identifier = identifier
    }
    
    var body: some View {
        if showEditView {
            EditContactView(contact: $contact, showEditView: $showEditView)
        }
        else {
            ContactDetailView(contact: contact, showEditView: $showEditView)
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(identifier: Store.shared.contacts[0].identifier)
    }
}
