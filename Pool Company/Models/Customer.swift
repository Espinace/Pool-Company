//
//  Customer.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import Foundation

struct Customer: Identifiable, Codable {
    let id = UUID()
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var address: CustomerAddress
    var projects: [UUID] // Project IDs
    var notes: String
    var registrationDate: Date
    var preferredContactMethod: ContactMethod
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
