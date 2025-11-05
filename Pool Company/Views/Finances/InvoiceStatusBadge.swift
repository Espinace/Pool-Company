//
//  InvoiceStatusBadge.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import SwiftUI

struct InvoiceStatusBadge: View {
    let status: InvoiceStatus
    
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
        case .draft:
            return .gray
        case .sent:
            return .blue
        case .paid:
            return .green
        case .overdue:
            return .red
        }
    }
}
