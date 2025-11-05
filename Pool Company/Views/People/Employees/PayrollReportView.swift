//
//  PayrollReportView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import SwiftUI

struct PayrollReportView: View {
    let employees: [Employee]
    let services: [Service] // ADD THIS
    @Environment(\.presentationMode) var presentationMode
    
    var totalWeeklyPayroll: Double {
        employees.reduce(0) { $0 + $1.weeklyEarnings(from: services) } // FIX
    }
    
    var activeEmployeesPayroll: Double {
        employees.filter { $0.isActive }.reduce(0) { $0 + $1.weeklyEarnings(from: services) } // FIX
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    // Summary Cards
                    HStack(spacing: 16) {
                        ReportCard(title: "Total Weekly", value: String(format: "$%.2f", totalWeeklyPayroll), color: .green)
                        ReportCard(title: "Active Only", value: String(format: "$%.2f", activeEmployeesPayroll), color: .blue)
                    }
                    
                    // Employee Breakdown
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Weekly Payroll Breakdown")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(employees.filter { $0.weeklyEarnings(from: services) > 0 }) { employee in // FIX
                            PayrollEmployeeRow(employee: employee, services: services) // PASS services
                        }
                    }
                    .padding()
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationTitle("Payroll Report")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
