//
//  ProjectDetailView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import SwiftUI

struct ProjectDetailView: View {
    @Binding var project: Project
    @State private var showingMaterialSheet = false
    
    var body: some View {
        List {
            Section("Project Info") {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Client: \(project.clientName)")
                    Text("Start Date: \(project.startDate, formatter: dateFormatter)")
                    Text("Expected End: \(project.expectedEndDate, formatter: dateFormatter)")
                    StatusBadge(status: project.status)
                }
            }
            
            Section("Cost Summary") {
                HStack {
                    Text("Total Cost:")
                    Spacer()
                    Text("$\(project.totalCost, specifier: "%.2f")")
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("Paid Amount:")
                    Spacer()
                    Text("$\(project.paidAmount, specifier: "%.2f")")
                        .foregroundColor(.green)
                }
                HStack {
                    Text("Remaining:")
                    Spacer()
                    Text("$\(project.remainingAmount, specifier: "%.2f")")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle(project.name)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
