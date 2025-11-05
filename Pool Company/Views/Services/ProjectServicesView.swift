//
//  ProjectServicesView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 05/10/25.
//
import SwiftUI

struct ProjectServicesView: View {
    @Binding var project: Project
    @Binding var services: [Service]
    @Binding var employees: [Employee]
    @State private var showingAddService = false
    
    var projectServices: [Service] {
        services.filter { project.services.contains($0.id) }
    }
    
    var body: some View {
        List {
            Section("Project Info") {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Client: \(project.clientName)")
                    Text("Status: \(project.status.rawValue)")
                }
            }
            
            Section("Services") {
                ForEach(projectServices) { service in
                    ServiceRowView(
                        service: binding(for: service),
                        employees: employees
                    )
                }
                
                Button(action: { showingAddService = true }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Service")
                    }
                }
            }
        }
        .navigationTitle(project.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAddService) {
            AddServiceView(
                project: $project,
                services: $services,
                employees: $employees
            )
        }
    }
    
    private func binding(for service: Service) -> Binding<Service> {
        guard let index = services.firstIndex(where: { $0.id == service.id }) else {
            fatalError("Service not found")
        }
        return $services[index]
    }
}
