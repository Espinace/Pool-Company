//
//  Service.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 05/10/25.
//
import Foundation

struct Service: Identifiable, Codable {
    let id = UUID()
    var type: ServiceType
    var projectId: UUID
    var employeeIds: [UUID]
    var date: Date
    var pricePerEmployee: Double
    var notes: String
    var isCompleted: Bool
    
    var totalCost: Double {
        return pricePerEmployee * Double(employeeIds.count)
    }
}
