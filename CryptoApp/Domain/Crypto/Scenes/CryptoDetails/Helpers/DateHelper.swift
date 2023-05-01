//
//  DateHelper.swift
//  CryptoApp
//
//  Created by Nato Egnatashvili on 01.05.23.
//

import Foundation

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
    
    static var today: Double {
        let date = Date() // current date or replace with a specific date
        let calendar = Calendar.current
        let startTime = calendar.startOfDay(for: date)
        return startTime.timeIntervalSince1970
    }
}
