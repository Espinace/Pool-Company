//
//  CustomerRowView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import SwiftUI

struct CustomerRowView: View {
    let customer: Customer
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(customer.fullName)
                .font(.headline)
            
            Text(customer.email)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(customer.address.fullAddress)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            HStack {
                Text("Projects: \(customer.projects.count)")
                Spacer()
                Text("Contact: \(customer.preferredContactMethod.rawValue)")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding(.vertical, 2)
    }
}
