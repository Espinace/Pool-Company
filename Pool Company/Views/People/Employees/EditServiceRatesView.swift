//
//  EditServiceRatesView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 05/10/25.
//
import SwiftUI

struct EditServiceRatesView: View {
    @Binding var employee: Employee
    @Environment(\.presentationMode) var presentationMode
    
    @State private var rates: [ServiceType: String] = [:]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Service Rates for \(employee.fullName)") {
                    ForEach(ServiceType.allCases, id: \.self) { serviceType in
                        HStack {
                            Text(serviceType.rawValue)
                            Spacer()
                            TextField("Rate", text: binding(for: serviceType))
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 100)
                        }
                    }
                }
            }
            .navigationTitle("Edit Service Rates")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveRates()
                }
            )
            .onAppear {
                loadCurrentRates()
            }
        }
    }
    
    func binding(for serviceType: ServiceType) -> Binding<String> {
        return Binding(
            get: { rates[serviceType] ?? "" },
            set: { rates[serviceType] = $0 }
        )
    }
    
    func loadCurrentRates() {
        for serviceType in ServiceType.allCases {
            let currentRate = employee.getRateFor(serviceType: serviceType)
            rates[serviceType] = currentRate > 0 ? String(format: "%.2f", currentRate) : ""
        }
    }
    
    func saveRates() {
        var newRates: [EmployeeServiceRate] = []
        
        for serviceType in ServiceType.allCases {
            if let rateString = rates[serviceType],
               let rate = Double(rateString), rate > 0 {
                newRates.append(EmployeeServiceRate(serviceType: serviceType, rate: rate))
            }
        }
        
        employee.serviceRates = newRates
        presentationMode.wrappedValue.dismiss()
    }
}
