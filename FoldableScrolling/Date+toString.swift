// Kevin Li - 7:31 PM - 5/25/20

import Foundation

extension Date {

    var timeOnlyWithPadding: String {
        Formatter.timeOnlyWithPadding.string(from: self)
    }

    var fullDayOfWeek: String {
        Formatter.fullDayOfWeek.string(from: self)
    }

    var fullMonthWithDayOfWeek: String {
        Formatter.fullMonthWithDayOfWeek.string(from: self)
    }

}

extension Formatter {

    static let timeOnlyWithPadding: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

    static let fullDayOfWeek: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()

    static let fullMonthWithDayOfWeek: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MMMM d"
        return formatter
    }()

}
