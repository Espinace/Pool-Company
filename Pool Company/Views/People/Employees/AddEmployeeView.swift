//
//  AddEmployeeView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import SwiftUI

struct AddEmployeeView: View {
    @Binding var employees: [Employee]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var position = ""
    @State private var hireDate = Date()
    
    // Service rates
    @State private var poolRate = ""
    @State private var extraYardsRate = ""
    @State private var spaRate = ""
    @State private var poolInfinityRate = ""
    @State private var spaInfinityRate = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Personal Info") {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                }
                
                Section("Employment") {
                    TextField("Position", text: $position)
                        .autocapitalization(.words)
                    DatePicker("Hire Date", selection: $hireDate, displayedComponents: .date)
                }
                
                Section("Service Rates") {
                    HStack {
                        Text("Pool")
                        Spacer()
                        TextField("Rate", text: $poolRate)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                    }
                    
                    HStack {
                        Text("Extra Yards")
                        Spacer()
                        TextField("Rate", text: $extraYardsRate)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                    }
                    
                    HStack {
                        Text("SPA")
                        Spacer()
                        TextField("Rate", text: $spaRate)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                    }
                    
                    HStack {
                        Text("Pool Infinity")
                        Spacer()
                        TextField("Rate", text: $poolInfinityRate)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                    }
                    
                    HStack {
                        Text("SPA Infinity")
                        Spacer()
                        TextField("Rate", text: $spaInfinityRate)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 100)
                    }
                }
            }
            .navigationTitle("New Employee")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveEmployee()
                }
                .disabled(firstName.isEmpty || lastName.isEmpty || position.isEmpty)
            )
        }
    }
    
    func saveEmployee() {
        var serviceRates: [EmployeeServiceRate] = []
        
        if let rate = Double(poolRate), rate > 0 {
            serviceRates.append(EmployeeServiceRate(serviceType: .pool, rate: rate))
        }
        if let rate = Double(extraYardsRate), rate > 0 {
            serviceRates.append(EmployeeServiceRate(serviceType: .extraYards, rate: rate))
        }
        if let rate = Double(spaRate), rate > 0 {
            serviceRates.append(EmployeeServiceRate(serviceType: .spa, rate: rate))
        }
        if let rate = Double(poolInfinityRate), rate > 0 {
            serviceRates.append(EmployeeServiceRate(serviceType: .poolInfinity, rate: rate))
        }
        if let rate = Double(spaInfinityRate), rate > 0 {
            serviceRates.append(EmployeeServiceRate(serviceType: .spaInfinity, rate: rate))
        }
        
        let newEmployee = Employee(
            firstName: firstName.trimmingCharacters(in: .whitespacesAndNewlines),
            lastName: lastName.trimmingCharacters(in: .whitespacesAndNewlines),
            email: email.trimmingCharacters(in: .whitespacesAndNewlines),
            phone: phone.trimmingCharacters(in: .whitespacesAndNewlines),
            position: position.trimmingCharacters(in: .whitespacesAndNewlines),
            hireDate: hireDate,
            isActive: true,
            serviceRates: serviceRates,
            completedServices: []
        )
        
        employees.append(newEmployee)
        presentationMode.wrappedValue.dismiss()
    }
}
