import SwiftUI

struct EditBirthdayView: View {
    @Binding var birthday: String
    @State private var showCalendar = false
    
    var body: some View {
        HStack {
            TextField("Birthday", text: $birthday)
                .disabled(true)
            
            Button(action: {
                showCalendar = true
            }, label: {
                Image(systemName: "calendar")
            })
                .sheet(isPresented: $showCalendar, content: {
                    SelectDateView(dateString: $birthday)
                })
            
            Button(action: {
                birthday = ""
            }, label: {
                Image(systemName: "xmark.circle")
            })
                .buttonStyle(.borderless)
        }
    }
}

struct EditBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            EditBirthdayView(birthday: .constant(""))
        }
    }
}
