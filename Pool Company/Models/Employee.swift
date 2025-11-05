//
//  Employee.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import Foundation

struct Employee: Identifiable, Codable {
    let id = UUID()
    var firstName: String
    var lastName: String
    var email: String
    var phone: String
    var position: String
    var hireDate: Date
    var isActive: Bool
    var serviceRates: [EmployeeServiceRate]
    var completedServices: [UUID] // Service IDs
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    func weeklyEarnings(from services: [Service]) -> Double {
        let calendar = Calendar.current
        let now = Date()
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: now)?.start ?? now
        
        return services
            .filter { service in
                completedServices.contains(service.id) &&
                service.employeeIds.contains(self.id) &&
                (calendar.isDate(service.date, inSameDayAs: startOfWeek) || service.date > startOfWeek)
            }
            .reduce(0) { total, service in
                total + service.pricePerEmployee
            }
    }
    
    func getRateFor(serviceType: ServiceType) -> Double {
        return serviceRates.first { $0.serviceType == serviceType }?.rate ?? 0
    }
}
