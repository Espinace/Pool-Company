//
//  ProjectStatusRow.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import SwiftUI

struct ProjectStatusRow: View {
    let status: ProjectStatus
    let count: Int
    let total: Int
    
    var percentage: Double {
        total == 0 ? 0 : Double(count) / Double(total)
    }
    
    var body: some View {
        HStack {
            StatusBadge(status: status)
            Text("\(count) projects")
            Spacer()
            Text("\(Int(percentage * 100))%")
                .fontWeight(.semibold)
        }
        .padding(.horizontal)
    }
}
