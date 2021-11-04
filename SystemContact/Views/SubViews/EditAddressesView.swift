import SwiftUI

struct EditAddressesView: View {
    @Binding var addresses: [AddressViewModel]
    
    var body: some View {
        Section("Address") {
            ForEach(0..<addresses.count, id: \.self) { index in
                HStack {
                    Button(action: {
                        addresses.remove(at: index)
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                    })
                        .buttonStyle(.borderless)

                    LabelPicker(labels: CNCommonLabels, type: $addresses[index].type, lowercased: true)
                        .frame(width: 80)
                    
                    Divider()
                    
                    VStack {
                        TextField("Street", text: $addresses[index].address.street1)
                        Divider()
                        
                        TextField("Street", text: $addresses[index].address.street2)
                        Divider()
                        
                        TextField("City", text: $addresses[index].address.city)
                        Divider()
                        
                        HStack {
                            TextField("State", text: $addresses[index].address.state)
                            Divider()
                            TextField("ZIP", text: $addresses[index].address.postalCode)
                        }
                        
                        Divider()
                        LabelPicker(labels: CountryList, type: $addresses[index].address.country)
                            .frame(height: 25)
                    }
                }
            }
            
            Button(action: {
                addresses.append(AddressViewModel())
            }, label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                    Text("add address")
                }
            })
        }
    }
}

struct EditAddressesView_Previews: PreviewProvider {
    static let addressVM: AddressDetailViewModel = {
        var address = AddressDetailViewModel()
        address.street1 = "123 Park Ave"
        address.street2 = "Room 205"
        address.city = "Irvine"
        address.state = "CA"
        address.postalCode = "92660"
        address.country = "USA"
        return address
    }()
    
    static var previews: some View {
        Form {
            EditAddressesView(addresses: .constant([
                AddressViewModel(type: CNCommonLabels[0], address: AddressDetailViewModel()),
                AddressViewModel(type: CNCommonLabels[1], address: addressVM)
            ]))
        }
    }
}
