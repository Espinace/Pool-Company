//
//  InvoiceStatus.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import Foundation

enum InvoiceStatus: String, CaseIterable, Codable {
    case draft = "Draft"
    case sent = "Sent"
    case paid = "Paid"
    case overdue = "Overdue"
}
