//
//  ProcessStep.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import Foundation

struct ProcessStep: Identifiable, Codable {
    let id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool
    var startDate: Date?
    var completionDate: Date?
    var assignedWorker: String
    var estimatedHours: Double
    var actualHours: Double?
}
