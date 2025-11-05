//
//  ServiceRowView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 05/10/25.
//
import SwiftUI

struct ServiceRowView: View {
    @Binding var service: Service
    let employees: [Employee]
    
    var assignedEmployees: [Employee] {
        employees.filter { service.employeeIds.contains($0.id) }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: service.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(service.isCompleted ? .green : .gray)
                    .font(.title3)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(service.type.rawValue)
                        .font(.headline)
                        .strikethrough(service.isCompleted)
                    
                    Text(service.date, formatter: dateFormatter)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("$\(service.totalCost, specifier: "%.2f")")
                        .font(.headline)
                        .foregroundColor(.green)
                    Text("\(service.employeeIds.count) workers")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            if !assignedEmployees.isEmpty {
                HStack {
                    Text("Workers:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(assignedEmployees.map { $0.fullName }.joined(separator: ", "))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            if !service.notes.isEmpty {
                Text(service.notes)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                service.isCompleted.toggle()
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
