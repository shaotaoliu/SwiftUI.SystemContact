import SwiftUI

struct EditEmailsView: View {
    @Binding var emails: [EmailViewModel]
    
    var body: some View {
        Section("Email") {
            ForEach(0..<emails.count, id: \.self) { index in
                HStack {
                    Button(action: {
                        emails.remove(at: index)
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                    })
                        .buttonStyle(.borderless)

                    LabelPicker(labels: CNCommonLabels, type: $emails[index].type, lowercased: true)
                        .frame(width: 80)
                    
                    Divider()
                    
                    TextField("Email", text: $emails[index].email)
                        .autocapitalization(.none)
                }
            }
            
            Button(action: {
                emails.append(EmailViewModel())
            }, label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                    Text("add email")
                }
            })
        }
    }
}

struct EditEmailsView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            EditEmailsView(emails: .constant([
                EmailViewModel(type: CNCommonLabels[0], email: "test@google.com"),
                EmailViewModel(type: CNCommonLabels[1], email: "example@yahoo.com"),
                EmailViewModel(type: CNCommonLabels[2], email: "hello@apple.com")
            ]))
        }
    }
}
