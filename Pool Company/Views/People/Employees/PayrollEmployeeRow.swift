//
//  PayrollEmployeeRow.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import SwiftUI

struct PayrollEmployeeRow: View {
    let employee: Employee
    let services: [Service] // ADD THIS
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(employee.fullName)
                    .font(.headline)
                Text(employee.position)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(String(format: "$%.2f", employee.weeklyEarnings(from: services))) // FIX
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                
                Text("\(employee.serviceRates.count) services")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
