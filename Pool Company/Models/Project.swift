//
//  Project.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//


import Foundation

struct Project: Identifiable, Codable {
    let id = UUID()
    var name: String
    var clientName: String
    var startDate: Date
    var expectedEndDate: Date
    var status: ProjectStatus
    var materials: [Material]
    var services: [UUID] // Service IDs instead of processSteps
    var totalCost: Double
    var paidAmount: Double
    
    var remainingAmount: Double {
        return totalCost - paidAmount
    }
}
