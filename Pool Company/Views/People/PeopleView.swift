//
//  PeopleView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import SwiftUI

struct PeopleView: View {
    @State private var employees: [Employee] = SampleData.employees
    @State private var customers: [Customer] = SampleData.customers
    @State private var selectedSegment = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("View", selection: $selectedSegment) {
                    Text("Employees").tag(0)
                    Text("Customers").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedSegment == 0 {
                    EmployeesView(employees: $employees)
                } else {
                    CustomersView(customers: $customers)
                }
            }
            .navigationTitle("People")
        }
    }
}
