//
//  DailyPayment.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import Foundation

struct DailyPayment: Identifiable, Codable {
    let id = UUID()
    var employeeId: UUID
    var date: Date
    var amount: Double
    var hoursWorked: Double
    var projectId: UUID?
    var notes: String
}
