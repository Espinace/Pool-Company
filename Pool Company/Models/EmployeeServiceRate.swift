//
//  EmployeeServiceRate.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 05/10/25.
//
import Foundation

struct EmployeeServiceRate: Identifiable, Codable {
    let id = UUID()
    var serviceType: ServiceType
    var rate: Double
}
