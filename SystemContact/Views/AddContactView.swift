import SwiftUI

struct AddContactView: View {
    @Binding var showAddView: Bool
    @State private var contact = ContactViewModel()
    
    var body: some View {
        NavigationView {
            EditContactView(contact: $contact, showEditView: $showAddView, operation: .add)
                .navigationTitle("New Contact")
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(showAddView: .constant(true))
    }
}
