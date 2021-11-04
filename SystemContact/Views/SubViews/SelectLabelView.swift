import SwiftUI

struct SelectLabelView: View {
    @Environment(\.presentationMode) var presentationMode
    var labels: [String]
    @Binding var label: String
    var lowercased = false
    
    var body: some View {
        VStack() {
            HStack() {
                Spacer()
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            
            List {
                ForEach(labels, id: \.self) { name in
                    Button(action: {
                        label = name
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Text(lowercased ? name.localized().lowercased() : name)
                            
                            Spacer()
                            
                            if name == label {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                                    .padding(.trailing)
                            }
                        }
                    })
                }
            }
            .listStyle(.plain)
        }
        .background(Gray92)
    }
}

struct SelectTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLabelView(labels: CNPhoneLabels, label: .constant(CNPhoneLabels[0]))
    }
}
