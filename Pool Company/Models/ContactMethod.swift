//
//  ContactMethod.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import Foundation

enum ContactMethod: String, CaseIterable, Codable {
    case email = "Email"
    case phone = "Phone"
    case text = "Text Message"
    case both = "Email & Phone"
}
