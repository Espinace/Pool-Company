//
//  AddProjectView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import SwiftUI

struct AddProjectView: View {
    @Binding var projects: [Project]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var projectName = ""
    @State private var clientName = ""
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(86400 * 30) // 30 days from now
    @State private var totalCost = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Project Details") {
                    TextField("Project Name", text: $projectName)
                    TextField("Client Name", text: $clientName)
                }
                
                Section("Timeline") {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("Expected End Date", selection: $endDate, displayedComponents: .date)
                }
                
                Section("Budget") {
                    TextField("Total Cost", text: $totalCost)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("New Project")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveProject()
                }
                .disabled(projectName.isEmpty || clientName.isEmpty)
            )
        }
    }
    
    func saveProject() {
        let newProject = Project(
            name: projectName,
            clientName: clientName,
            startDate: startDate,
            expectedEndDate: endDate,
            status: .planning,
            materials: [],
            services: [], // Changed from processSteps to services
            totalCost: Double(totalCost) ?? 0,
            paidAmount: 0
        )
        
        projects.append(newProject)
        presentationMode.wrappedValue.dismiss()
    }
}
