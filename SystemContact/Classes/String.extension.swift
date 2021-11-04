import Foundation
import Contacts

extension String {
    
    func toDate() -> Date? {
        if self.isEmpty {
            return nil
        }
        return dateFormatter.date(from: self)
    }
    
    func toDateComponents() -> DateComponents? {
        if self.isEmpty {
            return nil
        }
        
        let date = dateFormatter.date(from: self)!
        return Calendar.current.dateComponents([.year, .month, .day], from: date)
    }
    
    func localized() -> String {
        return CNLabeledValue<NSString>.localizedString(forLabel: self)
    }
}
