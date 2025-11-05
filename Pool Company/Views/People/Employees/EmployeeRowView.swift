//
//  EmployeeRowView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import SwiftUI

struct EmployeeRowView: View {
    let employee: Employee
    @State private var services: [Service] = SampleData.services
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(employee.fullName)
                    .font(.headline)
                Spacer()
                if employee.isActive {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                }
            }
            
            Text(employee.position)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Text("\(employee.serviceRates.count) services configured")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text("Week: $\(employee.weeklyEarnings(from: services), specifier: "%.2f")")
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical, 2)
    }
}
