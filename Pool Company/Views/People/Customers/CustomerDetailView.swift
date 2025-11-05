//
//  CustomerDetailView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import SwiftUI

struct CustomerDetailView: View {
    @Binding var customer: Customer
    
    var body: some View {
        List {
            Section("Customer Info") {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email: \(customer.email)")
                    Text("Phone: \(customer.phone)")
                    Text("Preferred Contact: \(customer.preferredContactMethod.rawValue)")
                    Text("Registered: \(customer.registrationDate, formatter: dateFormatter)")
                }
            }
            
            Section("Address") {
                VStack(alignment: .leading, spacing: 4) {
                    Text(customer.address.street)
                    Text("\(customer.address.city), \(customer.address.state)")
                    Text("\(customer.address.zipCode), \(customer.address.country)")
                }
            }
            
            Section("Projects") {
                if customer.projects.isEmpty {
                    Text("No projects yet")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(customer.projects, id: \.self) { projectId in
                        Text("Project ID: \(projectId.uuidString.prefix(8))")
                    }
                }
            }
            
            Section("Notes") {
                if customer.notes.isEmpty {
                    Text("No notes")
                        .foregroundColor(.secondary)
                } else {
                    Text(customer.notes)
                }
            }
        }
        .navigationTitle(customer.fullName)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
