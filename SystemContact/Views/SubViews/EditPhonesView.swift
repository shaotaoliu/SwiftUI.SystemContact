import SwiftUI

struct EditPhonesView: View {
    @Binding var phoneNumbers: [PhoneViewModel]
    
    var body: some View {
        Section("Phone") {
            ForEach(0..<phoneNumbers.count, id: \.self) { index in
                HStack {
                    Button(action: {
                        phoneNumbers.remove(at: index)
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                    })
                        .buttonStyle(.borderless)

                    LabelPicker(labels: CNPhoneLabels, type: $phoneNumbers[index].type, lowercased: true)
                        .frame(width: 80)
                    
                    Divider()
                    TextField("Phone", text: $phoneNumbers[index].phone)
                }
            }
            
            Button(action: {
                phoneNumbers.append(PhoneViewModel())
            }, label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                    Text("add phone")
                }
            })
        }
    }
}

struct EditPhonesView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            EditPhonesView(phoneNumbers: .constant([
                PhoneViewModel(type: CNPhoneLabels[0], phone: "(909) 123-4567"),
                PhoneViewModel(type: CNPhoneLabels[1], phone: "(800) 222-8888"),
                PhoneViewModel(type: CNPhoneLabels[2], phone: "(626) 980-3311")
            ]))
        }
    }
}
