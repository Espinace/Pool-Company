//
//  EmployeeDetailView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import SwiftUI

struct EmployeeDetailView: View {
    @Binding var employee: Employee
    @State private var services: [Service] = SampleData.services
    @State private var showingEditRates = false
    
    var employeeServices: [Service] {
        services.filter {
            $0.employeeIds.contains(employee.id) &&
            employee.completedServices.contains($0.id)
        }.sorted { $0.date > $1.date }
    }
    
    var weeklyServices: [Service] {
        let calendar = Calendar.current
        let now = Date()
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: now)?.start ?? now
        
        return employeeServices.filter { service in
            calendar.isDate(service.date, inSameDayAs: startOfWeek) || service.date > startOfWeek
        }
    }
    
    var body: some View {
        List {
            Section("Employee Info") {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Position: \(employee.position)")
                    Text("Email: \(employee.email)")
                    Text("Phone: \(employee.phone)")
                    Text("Hire Date: \(employee.hireDate, formatter: dateFormatter)")
                    HStack {
                        Text("Status:")
                        Text(employee.isActive ? "Active" : "Inactive")
                            .foregroundColor(employee.isActive ? .green : .red)
                            .fontWeight(.semibold)
                    }
                }
            }
            
            Section(header: HStack {
                Text("Service Rates")
                Spacer()
                Button("Edit") {
                    showingEditRates = true
                }
                .font(.caption)
            }) {
                ForEach(ServiceType.allCases, id: \.self) { serviceType in
                    HStack {
                        Text(serviceType.rawValue)
                        Spacer()
                        Text("$\(employee.getRateFor(serviceType: serviceType), specifier: "%.2f")")
                            .fontWeight(.semibold)
                            .foregroundColor(.green)
                    }
                }
            }
            
            Section("Weekly Earnings") {
                HStack {
                    Text("This Week Total:")
                    Spacer()
                    Text("$\(employee.weeklyEarnings(from: services), specifier: "%.2f")")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                Text("\(weeklyServices.count) services completed")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Section("Recent Services") {
                if employeeServices.isEmpty {
                    Text("No services yet")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(employeeServices.prefix(10)) { service in
                        EmployeeServiceRowView(service: service)
                    }
                }
            }
        }
        .navigationTitle(employee.fullName)
        .sheet(isPresented: $showingEditRates) {
            EditServiceRatesView(employee: $employee)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct EmployeeServiceRowView: View {
    let service: Service
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(service.type.rawValue)
                    .font(.headline)
                Spacer()
                Text("$\(service.pricePerEmployee, specifier: "%.2f")")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
            
            HStack {
                Text(service.date, formatter: dateFormatter)
                Spacer()
                if service.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
