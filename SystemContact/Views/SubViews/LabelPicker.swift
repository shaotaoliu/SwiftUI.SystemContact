import SwiftUI

struct LabelPicker: View {
    var labels: [String]
    @Binding var type: String
    @State var showPicker = false
    var lowercased = false
    
    var body: some View {
        Button(action: {
            showPicker = true
        }, label: {
            HStack {
                Text(lowercased ? type.localized().lowercased() : type)
                Spacer()
                Image(systemName: "chevron.forward")
                    .foregroundColor(Gray80)
                    .padding(.trailing, 5)
            }
        })
            .frame(alignment: .leading)
            .buttonStyle(.borderless)
            .sheet(isPresented: $showPicker, content: {
                SelectLabelView(labels: labels, label: $type, lowercased: lowercased)
            })
    }
}


struct LabelPicker_Previews: PreviewProvider {
    static var previews: some View {
        LabelPicker(labels: CNPhoneLabels, type: .constant(CNPhoneLabels[0]))
    }
}
