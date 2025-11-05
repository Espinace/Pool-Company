//
//  CustomerAddress.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import Foundation

struct CustomerAddress: Codable {
    var street: String
    var city: String
    var state: String
    var zipCode: String
    var country: String
    
    var fullAddress: String {
        return "\(street), \(city), \(state) \(zipCode), \(country)"
    }
}
