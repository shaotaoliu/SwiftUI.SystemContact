import SwiftUI
import ImagePicker

struct EditContactView: View {
    @Binding var contact: ContactViewModel
    @Binding var showEditView: Bool
    var operation = Operation.edit
    
    @State private var editContact: ContactViewModel
    @State private var showPhotoPicker = false
    //@State private var showCalendar = false
    @State private var showDeleteConfirmation = false
    
    init(contact: Binding<ContactViewModel>, showEditView: Binding<Bool>, operation: Operation = .edit) {
        self._contact = contact
        self._showEditView = showEditView
        self.operation = operation
        editContact = contact.wrappedValue
    }
    
    var body: some View {
        VStack {
            PhotoSection
            
            Form {
                Group {
                    TextField("Last Name", text: $editContact.lastName)
                    TextField("Middle Name", text: $editContact.middleName)
                    TextField("First Name", text: $editContact.firstName)
                    TextField("Nickname", text: $editContact.nickname)
                }
                
                Section("Company") {
                    TextField("Title", text: $editContact.jobTitle)
                    TextField("Department", text: $editContact.departmentName)
                    TextField("Company", text: $editContact.organizationName)
                }
                
                Group {
                    EditPhonesView(phoneNumbers: $editContact.phoneNumbers)
                    EditEmailsView(emails: $editContact.emailAddresses)
                    EditAddressesView(addresses: $editContact.postalAddresses)
                    EditUrlsView(urls: $editContact.urlAddresses)
                    EditBirthdayView(birthday: $editContact.birthday)
                }
                
                if operation == .edit {
                    DeleteSection
                }
            }
            
            //if showCalendar {
                
            //}
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CancelButton, trailing: SaveButton)
    }
    
    var PhotoSection: some View {
        VStack {
            ContactPhotoView(photo: editContact.photo, width: 200, height: 200)
            
            Button("\(editContact.photo == nil ? "Add" : "Change") Photo") {
                showPhotoPicker = true
            }
            .sheet(isPresented: $showPhotoPicker) {
                ImagePicker(sourceType: .library, selectedImage: $editContact.photo)
                    .ignoresSafeArea()
            }
        }
    }
    
    var DeleteSection: some View {
        Section {
            Button(action: {
                showDeleteConfirmation = true
            }, label: {
                Label("Delete This Contact", systemImage: "trash")
            })
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowBackground(Color(UIColor.systemGroupedBackground))
                .confirmationDialog("Confirm", isPresented: $showDeleteConfirmation, actions: {
                    Button("Delete") {
                        if Store.shared.delete(identifier: contact.identifier) {
                            showEditView = false
                        }
                    }
                }, message: {
                    Text("Are you sure you want to delete?")
                })
        }
    }
    
    var SaveButton: some View {
        Button("Save") {
            if Store.shared.save(contact: editContact) {
                contact = editContact
                showEditView = false
            }
        }
    }
    
    var CancelButton: some View {
        Button("Cancel") {
            showEditView = false
        }
    }
    
    var dateRange: ClosedRange<Date> {
        let today = Date()
        let min = Calendar.current.date(byAdding: .year, value: -200, to: today)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: today)!
        return min...max
    }
}

struct EditContactView_Previews: PreviewProvider {
    static var previews: some View {
        EditContactView(contact: .constant(ContactViewModel()), showEditView: .constant(true))
    }
}
