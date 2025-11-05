//
//  InvoiceRowView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import SwiftUI

struct InvoiceRowView: View {
    let invoice: Invoice
    let projectName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Invoice #\(invoice.invoiceNumber)")
                    .font(.headline)
                Spacer()
                InvoiceStatusBadge(status: invoice.status)
            }
            
            Text(projectName)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            HStack {
                Text("Due: \(invoice.dueDate, formatter: dateFormatter)")
                Spacer()
                Text("$\(invoice.amount, specifier: "%.2f")")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .font(.subheadline)
        }
        .padding(.vertical, 2)
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
