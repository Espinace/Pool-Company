//
//  InvoicesListView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import SwiftUI

struct InvoicesListView: View {
    @Binding var invoices: [Invoice]
    let projects: [Project]
    
    var body: some View {
        List {
            ForEach(invoices) { invoice in
                InvoiceRowView(invoice: invoice, projectName: getProjectName(for: invoice.projectId))
            }
        }
    }
    
    func getProjectName(for projectId: UUID) -> String {
        return projects.first { $0.id == projectId }?.name ?? "Unknown Project"
    }
}
