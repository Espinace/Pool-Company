//
//  ServicesView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 05/10/25.
//


import SwiftUI

struct ServicesView: View {
    @State private var projects: [Project] = SampleData.projects
    @State private var services: [Service] = SampleData.services
    @State private var employees: [Employee] = SampleData.employees
    
    var activeProjects: [Project] {
        projects.filter { $0.status == .inProgress || $0.status == .planning }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Active Projects") {
                    if activeProjects.isEmpty {
                        Text("No active projects")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(activeProjects) { project in
                            NavigationLink(destination: ProjectServicesView(
                                project: binding(for: project),
                                services: $services,
                                employees: $employees
                            )) {
                                ProjectServiceRowView(project: project, services: services)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Services")
        }
    }
    
    private func binding(for project: Project) -> Binding<Project> {
        guard let index = projects.firstIndex(where: { $0.id == project.id }) else {
            fatalError("Project not found")
        }
        return $projects[index]
    }
}

struct ProjectServiceRowView: View {
    let project: Project
    let services: [Service]
    
    var projectServices: [Service] {
        services.filter { project.services.contains($0.id) }
    }
    
    var completedCount: Int {
        projectServices.filter { $0.isCompleted }.count
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(project.name)
                .font(.headline)
            Text("Client: \(project.clientName)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack {
                StatusBadge(status: project.status)
                Spacer()
                Text("\(completedCount)/\(projectServices.count) services")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 2)
    }
}
