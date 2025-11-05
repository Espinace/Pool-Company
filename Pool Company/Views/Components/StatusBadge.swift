//
//  StatusBadge.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import SwiftUI

struct StatusBadge: View {
    let status: ProjectStatus
    
    var body: some View {
        Text(status.rawValue)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(statusColor)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
    
    var statusColor: Color {
        switch status {
        case .planning:
            return .orange
        case .inProgress:
            return .blue
        case .completed:
            return .green
        case .onHold:
            return .red
        }
    }
}
