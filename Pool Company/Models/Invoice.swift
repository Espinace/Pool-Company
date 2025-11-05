//
//  Invoice.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import Foundation

struct Invoice: Identifiable, Codable {
    let id = UUID()
    var invoiceNumber: String
    var projectId: UUID
    var amount: Double
    var issueDate: Date
    var dueDate: Date
    var status: InvoiceStatus
    var description: String
}


