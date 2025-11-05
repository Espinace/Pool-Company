//
//  AddServiceView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 05/10/25.
//
import SwiftUI

struct AddServiceView: View {
    @Binding var project: Project
    @Binding var services: [Service]
    @Binding var employees: [Employee]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedServiceType: ServiceType = .pool
    @State private var selectedEmployeeIds: Set<UUID> = []
    @State private var serviceDate = Date()
    @State private var notes = ""
    
    var selectedEmployees: [Employee] {
        employees.filter { selectedEmployeeIds.contains($0.id) }
    }
    
    var totalCost: Double {
        selectedEmployees.reduce(0) { total, employee in
            total + employee.getRateFor(serviceType: selectedServiceType)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Service Type") {
                    Picker("Service", selection: $selectedServiceType) {
                        ForEach(ServiceType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Date") {
                    DatePicker("Service Date", selection: $serviceDate, displayedComponents: .date)
                }
                
                Section("Assign Workers") {
                    ForEach(employees.filter { $0.isActive }) { employee in
                        EmployeeSelectionRow(
                            employee: employee,
                            serviceType: selectedServiceType,
                            isSelected: selectedEmployeeIds.contains(employee.id)
                        ) { isSelected in
                            if isSelected {
                                selectedEmployeeIds.insert(employee.id)
                            } else {
                                selectedEmployeeIds.remove(employee.id)
                            }
                        }
                    }
                }
                
                Section("Cost Summary") {
                    ForEach(selectedEmployees) { employee in
                        HStack {
                            Text(employee.fullName)
                            Spacer()
                            Text("$\(employee.getRateFor(serviceType: selectedServiceType), specifier: "%.2f")")
                                .foregroundColor(.green)
                        }
                        .font(.subheadline)
                    }
                    
                    HStack {
                        Text("Total Cost:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text("$\(totalCost, specifier: "%.2f")")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                }
                
                Section("Notes") {
                    TextField("Additional notes (optional)", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Add Service")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveService()
                }
                .disabled(selectedEmployeeIds.isEmpty)
            )
        }
    }
    
    func saveService() {
        let pricePerEmployee = totalCost / Double(selectedEmployeeIds.count)
        
        let newService = Service(
            type: selectedServiceType,
            projectId: project.id,
            employeeIds: Array(selectedEmployeeIds),
            date: serviceDate,
            pricePerEmployee: pricePerEmployee,
            notes: notes,
            isCompleted: false
        )
        
        services.append(newService)
        project.services.append(newService.id)
        
        // Update employees' completed services
        for employeeId in selectedEmployeeIds {
            if let index = employees.firstIndex(where: { $0.id == employeeId }) {
                employees[index].completedServices.append(newService.id)
            }
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct EmployeeSelectionRow: View {
    let employee: Employee
    let serviceType: ServiceType
    let isSelected: Bool
    let onToggle: (Bool) -> Void
    
    var body: some View {
        Button(action: { onToggle(!isSelected) }) {
            HStack {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(employee.fullName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(employee.position)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text("$\(employee.getRateFor(serviceType: serviceType), specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
        }
    }
}
