//
//  FinancesView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import SwiftUI

struct FinancesView: View {
    @State private var invoices: [Invoice] = SampleData.invoices
    @State private var projects: [Project] = SampleData.projects
    @State private var employees: [Employee] = SampleData.employees
    @State private var services: [Service] = SampleData.services
    @State private var selectedSegment = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("View", selection: $selectedSegment) {
                    Text("Invoices").tag(0)
                    Text("Labor Costs").tag(1)
                    Text("Reports").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedSegment {
                case 0:
                    InvoicesListView(invoices: $invoices, projects: projects)
                case 1:
                    LaborCostsView(employees: employees, services: services)
                case 2:
                    ReportsView(projects: projects, invoices: invoices, employees: employees, services: services)
                default:
                    EmptyView()
                }
            }
            .navigationTitle("Finances")
        }
    }
}
