//
//  CustomerView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import SwiftUI

struct CustomersView: View {
    @Binding var customers: [Customer]
    @State private var showingAddCustomer = false
    
    var body: some View {
        VStack {
            // Quick Stats
            HStack(spacing: 16) {
                StatCard(title: "Total Customers", value: "\(customers.count)", color: .blue)
                StatCard(title: "This Month", value: "\(customersThisMonth)", color: .purple)
            }
            .padding(.horizontal)
            
            List {
                ForEach(customers) { customer in
                    NavigationLink(destination: CustomerDetailView(customer: $customers[customers.firstIndex(where: { $0.id == customer.id })!])) {
                        CustomerRowView(customer: customer)
                    }
                }
                .onDelete(perform: deleteCustomers)
            }
        }
        .navigationBarItems(trailing: Button("Add Customer") {
            showingAddCustomer = true
        })
        .sheet(isPresented: $showingAddCustomer) {
            AddCustomerView(customers: $customers)
        }
    }
    
    var customersThisMonth: Int {
        let calendar = Calendar.current
        let now = Date()
        return customers.filter { calendar.isDate($0.registrationDate, equalTo: now, toGranularity: .month) }.count
    }
    
    func deleteCustomers(offsets: IndexSet) {
        customers.remove(atOffsets: offsets)
    }
}
