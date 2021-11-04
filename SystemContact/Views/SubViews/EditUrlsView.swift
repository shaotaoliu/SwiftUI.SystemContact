import SwiftUI

struct EditUrlsView: View {
    @Binding var urls: [UrlViewModel]
    
    var body: some View {
        Section("URL") {
            ForEach(0..<urls.count, id: \.self) { index in
                HStack {
                    Button(action: {
                        urls.remove(at: index)
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                    })
                        .buttonStyle(.borderless)

                    LabelPicker(labels: CNCommonLabels, type: $urls[index].type, lowercased: true)
                        .frame(width: 80)
                    
                    Divider()
                    
                    TextField("URL", text: $urls[index].url)
                        .autocapitalization(.none)
                }
            }
            
            Button(action: {
                urls.append(UrlViewModel())
            }, label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                    Text("add url")
                }
            })
        }
    }
}

struct EditUrlsView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            EditUrlsView(urls: .constant([
                UrlViewModel(type: CNCommonLabels[0], url: "www.google.com"),
                UrlViewModel(type: CNCommonLabels[1], url: "www.apple.com"),
                UrlViewModel(type: CNCommonLabels[2], url: "www.hello.com")
            ]))
        }
    }
}
