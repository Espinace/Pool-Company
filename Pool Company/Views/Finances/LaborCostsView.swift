//
//  LaborCostsView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 05/10/25.
//
import SwiftUI

struct LaborCostsView: View {
    let employees: [Employee]
    let services: [Service]
    
    var weeklyLaborCost: Double {
        employees.reduce(0) { $0 + $1.weeklyEarnings(from: services) }
    }
    
    var monthlyLaborCost: Double {
        let calendar = Calendar.current
        let now = Date()
        let startOfMonth = calendar.dateInterval(of: .month, for: now)?.start ?? now
        
        return services
            .filter { service in
                calendar.isDate(service.date, inSameDayAs: startOfMonth) || service.date > startOfMonth
            }
            .reduce(0) { $0 + $1.totalCost }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                HStack(spacing: 16) {
                    ReportCard(title: "Weekly Labor", value: String(format: "$%.2f", weeklyLaborCost), color: .orange)
                    ReportCard(title: "Monthly Labor", value: String(format: "$%.2f", monthlyLaborCost), color: .red)
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
        }
    }
}
