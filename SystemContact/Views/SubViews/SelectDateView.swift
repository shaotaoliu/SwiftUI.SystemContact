import SwiftUI

struct SelectDateView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var dateString: String
    @State private var date: Date = Date()

    var body: some View {
        NavigationView {
            VStack() {
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.wheel)
                
                Spacer()
            }
            .navigationTitle("Select Date")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: CancelButton, trailing: AddButton)
            .onAppear() {
                if !dateString.isEmpty {
                    date = dateString.toDate()!
                }
            }
        }
    }
    
    var CancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var AddButton: some View {
        Button("Add") {
            dateString = dateFormatter.string(from: date)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct SelectDateView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDateView(dateString: .constant(""))
    }
}
