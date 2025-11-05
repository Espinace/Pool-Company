//
//  DailyPaymentRowView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import SwiftUI

struct DailyPaymentRowView: View {
    let payment: DailyPayment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(payment.date, formatter: dateFormatter)
                    .font(.headline)
                Spacer()
                Text("$\(payment.amount, specifier: "%.2f")")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
            
            HStack {
                Text("Hours: \(payment.hoursWorked, specifier: "%.1f")")
                Spacer()
                if !payment.notes.isEmpty {
                    Text(payment.notes)
                        .lineLimit(1)
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
