//
//  ExecutionMaterialsView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//


import SwiftUI

struct ExecutionMaterialsView: View {
    @State private var projects: [Project] = SampleData.projects
    @State private var showingAddProject = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects) { project in
                    NavigationLink(destination: ProjectDetailView(project: $projects[projects.firstIndex(where: { $0.id == project.id })!])) {
                        ProjectRowView(project: project)
                    }
                }
                .onDelete(perform: deleteProjects)
            }
            .navigationTitle("Projects")
            .navigationBarItems(trailing: Button("Add") {
                showingAddProject = true
            })
            .sheet(isPresented: $showingAddProject) {
                AddProjectView(projects: $projects)
            }
        }
    }
    
    func deleteProjects(offsets: IndexSet) {
        projects.remove(atOffsets: offsets)
    }
}
