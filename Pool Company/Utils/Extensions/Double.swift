//
//  Double+Extensions.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import Foundation

extension Double {
    /// Format as currency string (e.g., "$1,234.56")
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }
    
    /// Format as currency string without symbol (e.g., "1,234.56")
    var currencyStringNoSymbol: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "0.00"
    }
    
    /// Format as percentage (e.g., "75.5%")
    var percentageString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter.string(from: NSNumber(value: self / 100)) ?? "0%"
    }
    
    /// Format as hours string (e.g., "8.5 hrs")
    var hoursString: String {
        if self == floor(self) {
            return String(format: "%.0f hrs", self)
        } else {
            return String(format: "%.1f hrs", self)
        }
    }
    
    /// Format as short hours string (e.g., "8.5h")
    var shortHoursString: String {
        if self == floor(self) {
            return String(format: "%.0fh", self)
        } else {
            return String(format: "%.1fh", self)
        }
    }
    
    /// Round to specified decimal places
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    /// Check if value is positive
    var isPositive: Bool {
        return self > 0
    }
    
    /// Check if value is negative
    var isNegative: Bool {
        return self < 0
    }
    
    /// Get absolute value
    var absoluteValue: Double {
        return abs(self)
    }
}
