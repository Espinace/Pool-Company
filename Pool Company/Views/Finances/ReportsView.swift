//
//  ReportsView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import SwiftUI

struct ReportsView: View {
    let projects: [Project]
    let invoices: [Invoice]
    let employees: [Employee]
    let services: [Service]
    
    var totalRevenue: Double {
        invoices.filter { $0.status == .paid }.reduce(0) { $0 + $1.amount }
    }
    
    var pendingRevenue: Double {
        invoices.filter { $0.status != .paid }.reduce(0) { $0 + $1.amount }
    }
    
    var totalLaborCosts: Double {
        services.reduce(0) { $0 + $1.totalCost }
    }
    
    var netProfit: Double {
        return totalRevenue - totalLaborCosts
    }
    
    var activeProjects: Int {
        projects.filter { $0.status == .inProgress }.count
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                // Revenue Cards
                HStack(spacing: 16) {
                    ReportCard(title: "Total Revenue", value: String(format: "$%.2f", totalRevenue), color: .green)
                    ReportCard(title: "Pending", value: String(format: "$%.2f", pendingRevenue), color: .orange)
                }
                
                // Costs and Profit
                HStack(spacing: 16) {
                    ReportCard(title: "Labor Costs", value: String(format: "$%.2f", totalLaborCosts), color: .red)
                    ReportCard(title: "Net Profit", value: String(format: "$%.2f", netProfit), color: netProfit >= 0 ? .green : .red)
                }
                
                // Project Stats
                HStack(spacing: 16) {
                    ReportCard(title: "Active Projects", value: "\(activeProjects)", color: .blue)
                    ReportCard(title: "Total Projects", value: "\(projects.count)", color: .purple)
                }
                
                // Project Status Overview
                VStack(alignment: .leading, spacing: 12) {
                    Text("Project Status Overview")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(ProjectStatus.allCases, id: \.self) { status in
                        let count = projects.filter { $0.status == status }.count
                        ProjectStatusRow(status: status, count: count, total: projects.count)
                    }
                }
                .padding()
                .background(Color(.systemGroupedBackground))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding(.top)
        }
    }
}

