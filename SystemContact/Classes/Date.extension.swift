import Foundation

extension Date {
    func toString() -> String {
        return dateFormatter.string(from: self)
    }
}

extension DateComponents {
    func toString() -> String {
        let date = NSCalendar.current.date(from: self)!
        return dateFormatter.string(from: date)
    }
}

let dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
