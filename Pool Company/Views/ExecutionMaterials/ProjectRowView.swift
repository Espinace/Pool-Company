//
//  ProjectRowView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import SwiftUI

struct ProjectRowView: View {
    let project: Project
    
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
                Text("$\(project.totalCost, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
        }
        .padding(.vertical, 2)
    }
}
