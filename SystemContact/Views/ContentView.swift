import SwiftUI

struct ContentView: View {
    @StateObject private var store = Store.shared
    @State private var showAddSheet = false
    @State private var showDeleteConfirmation = false
    @State private var deleteSet: IndexSet? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.contacts, id: \.identifier) { contact in
                    NavigationLink(destination: ContactView(identifier: contact.identifier)) {
                        Text(contact.fullName)
                    }
                }
                .onDelete { offsets in
                    deleteSet = offsets
                    showDeleteConfirmation = true
                }
            }
            .listStyle(.plain)
            .navigationTitle("Contacts")
            .navigationBarItems(trailing: Button(action: {
                showAddSheet = true
            }, label: {
                Image(systemName: "plus")
            }))
        }
        .disabled(!store.hasPermission)
        .sheet(isPresented: $showAddSheet, content: {
            AddContactView(showAddView: $showAddSheet)
        })
        .alert("Error", isPresented: $store.hasError, presenting: store.errorMessage, actions: { errorMessage in
        }, message: { errorMessage in
            Text(errorMessage)
        })
        .confirmationDialog("Confirm", isPresented: $showDeleteConfirmation, actions: {
            Button("Delete") {
                store.deleteAll(identifiers: deleteSet!.map { store.contacts[$0].identifier })
            }
        }, message: {
            Text("Are you sure you want to delete?")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
