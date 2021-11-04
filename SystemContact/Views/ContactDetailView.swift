import SwiftUI

struct ContactDetailView: View {
    var contact: ContactViewModel
    @Binding var showEditView: Bool
    
    var body: some View {
        VStack {
            Text(contact.fullName)
                .font(.title3)
                .bold()
            
            if !contact.nickname.isEmpty {
                Text("(\(contact.nickname))")
            }
            
            ContactPhotoView(photo: contact.photo, width: 200, height: 200)
            
            Form {
                if !contact.jobTitle.isEmpty {
                    FieldRow(text: "Title", value: contact.jobTitle)
                }
                
                if !contact.departmentName.isEmpty {
                    FieldRow(text: "Department", value: contact.departmentName)
                }
                
                if !contact.organizationName.isEmpty {
                    FieldRow(text: "Company", value: contact.organizationName)
                }
                
                if contact.phoneNumbers.count > 0 {
                    Section("Phone") {
                        ForEach(contact.phoneNumbers, id: \.id) { phone in
                            FieldRow(text: phone.type.localized(), value: phone.phone)
                        }
                    }
                }
                
                if contact.emailAddresses.count > 0 {
                    Section("Email") {
                        ForEach(contact.emailAddresses, id: \.id) { email in
                            FieldRow(text: email.type.localized(), value: email.email)
                        }
                    }
                }
                
                if contact.postalAddresses.count > 0 {
                    Section("Address") {
                        ForEach(contact.postalAddresses, id: \.id) { address in
                            FieldRow(text: address.type.localized(), value: address.address.combined)
                        }
                    }
                }
                
                if contact.urlAddresses.count > 0 {
                    Section("Url") {
                        ForEach(contact.urlAddresses, id: \.id) { url in
                            FieldRow(text: url.type.localized(), value: url.url)
                        }
                    }
                }
                
                if !contact.birthday.isEmpty {
                    FieldRow(text: "Birthday", value: contact.birthday)
                }
            }
            
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button("Edit") {
            showEditView = true
        })
    }
    
    struct FieldRow: View {
        let text: String
        let value: String
        
        var body: some View {
            HStack {
                Text(text.capitalized)
                    .frame(width: 100, alignment: .leading)
                
                Text(value)
                    .frame(alignment: .leading)
            }
        }
    }
}

struct ContactDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailView(contact: ContactViewModel(), showEditView: .constant(false))
    }
}
