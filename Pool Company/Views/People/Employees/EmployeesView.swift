//
//  EmployeesView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import SwiftUI

struct EmployeesView: View {
    @Binding var employees: [Employee]
    @State private var showingAddEmployee = false
    @State private var showingPayrollReport = false
    @State private var services: [Service] = SampleData.services // ADD THIS
    
    var body: some View {
        VStack {
            // Quick Stats
            HStack(spacing: 16) {
                StatCard(title: "Active Employees", value: "\(employees.filter { $0.isActive }.count)", color: .blue)
                StatCard(title: "Weekly Payroll", value: String(format: "$%.2f", weeklyPayroll), color: .green)
            }
            .padding(.horizontal)
            
            List {
                ForEach(employees) { employee in
                    NavigationLink(destination: EmployeeDetailView(employee: $employees[employees.firstIndex(where: { $0.id == employee.id })!])) {
                        EmployeeRowView(employee: employee)
                    }
                }
                .onDelete(perform: deleteEmployees)
            }
        }
        .navigationBarItems(
            leading: Button("Payroll Report") {
                showingPayrollReport = true
            },
            trailing: Button("Add Employee") {
                showingAddEmployee = true
            }
        )
        .sheet(isPresented: $showingAddEmployee) {
            AddEmployeeView(employees: $employees)
        }
        .sheet(isPresented: $showingPayrollReport) {
            PayrollReportView(employees: employees, services: services) // PASS services
        }
    }
    
    var weeklyPayroll: Double {
        employees.reduce(0) { $0 + $1.weeklyEarnings(from: services) } // FIX: Call function
    }
    
    func deleteEmployees(offsets: IndexSet) {
        employees.remove(atOffsets: offsets)
    }
}
