import Foundation
import Contacts

struct AddressViewModel {
    let id = UUID()
    var type: String = ""
    var address: AddressDetailViewModel = AddressDetailViewModel()
}

struct AddressDetailViewModel {
    var street1: String = ""
    var street2: String = ""
    var city: String = ""
    var state: String = ""
    var postalCode: String = ""
    var country: String = "United States"
    
    init() {}
    
    init(address: CNPostalAddress) {
        let streets = address.street.split(separator: "\n")
        if streets.count == 1 {
            street1 = String(streets[0])
        }
        else if streets.count == 2 {
            street1 = String(streets[0])
            street2 = String(streets[1])
        }
        
        city = address.city
        state = address.state
        postalCode = address.postalCode
        country = address.country
    }
    
    func toMutablePostalAddress() -> CNMutablePostalAddress {
        let mutablePostalAddress = CNMutablePostalAddress()
        mutablePostalAddress.street = street2.isEmpty ? street1 : "\(street1)\n\(street2)"
        mutablePostalAddress.city = city
        mutablePostalAddress.state = state
        mutablePostalAddress.postalCode = postalCode
        mutablePostalAddress.country = country
        return mutablePostalAddress
    }
    
    var combined: String {
        var address = street1
        if !street2.isEmpty {
            address = address.isEmpty ? street2 : "\(address)\n\(street2)"
        }
        
        var line = city
        if !state.isEmpty {
            line = line.isEmpty ? state : "\(line), \(state)"
        }
        if !postalCode.isEmpty {
            line = line.isEmpty ? postalCode : "\(line), \(postalCode)"
        }
        
        if !line.isEmpty {
            address = address.isEmpty ? line : "\(address)\n\(line)"
        }
        
        if !country.isEmpty {
            address = address.isEmpty ? country : "\(address)\n\(country)"
        }
        
        return address
    }
}
