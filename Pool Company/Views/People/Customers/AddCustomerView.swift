//
//  AddCustomerView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import SwiftUI

struct AddCustomerView: View {
    @Binding var customers: [Customer]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var street = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zipCode = ""
    @State private var country = "USA"
    @State private var preferredContact = ContactMethod.email
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Personal Info") {
                    TextField("First Name", text: $firstName)
                        .autocapitalization(.words)
                    TextField("Last Name", text: $lastName)
                        .autocapitalization(.words)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                }
                
                Section("Address") {
                    TextField("Street Address", text: $street)
                        .autocapitalization(.words)
                    TextField("City", text: $city)
                        .autocapitalization(.words)
                    TextField("State", text: $state)
                        .autocapitalization(.words)
                    TextField("Zip Code", text: $zipCode)
                        .keyboardType(.numberPad)
                    TextField("Country", text: $country)
                        .autocapitalization(.words)
                }
                
                Section("Communication Preferences") {
                    Picker("Preferred Contact Method", selection: $preferredContact) {
                        ForEach(ContactMethod.allCases, id: \.self) { method in
                            Text(method.rawValue).tag(method)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Additional Notes") {
                    TextField("Notes about customer (optional)", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section("Preview") {
                    if !firstName.isEmpty && !lastName.isEmpty {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(firstName) \(lastName)")
                                .fontWeight(.semibold)
                            if !email.isEmpty {
                                Text(email)
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                            if !street.isEmpty && !city.isEmpty {
                                Text("\(street), \(city)")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
            .navigationTitle("New Customer")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveCustomer()
                }
                .disabled(firstName.isEmpty || lastName.isEmpty || email.isEmpty)
            )
        }
    }
    
    func saveCustomer() {
            let address = CustomerAddress(
                street: street.trimmingCharacters(in: .whitespacesAndNewlines),
                city: city.trimmingCharacters(in: .whitespacesAndNewlines),
                state: state.trimmingCharacters(in: .whitespacesAndNewlines),
                zipCode: zipCode.trimmingCharacters(in: .whitespacesAndNewlines),
                country: country.trimmingCharacters(in: .whitespacesAndNewlines)
            )
            
            let newCustomer = Customer(
                firstName: firstName.trimmingCharacters(in: .whitespacesAndNewlines),
                lastName: lastName.trimmingCharacters(in: .whitespacesAndNewlines),
                email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                phone: phone.trimmingCharacters(in: .whitespacesAndNewlines),
                address: address,
                projects: [],
                notes: notes.trimmingCharacters(in: .whitespacesAndNewlines),
                registrationDate: Date(),
                preferredContactMethod: preferredContact
            )
            
            customers.append(newCustomer)
            presentationMode.wrappedValue.dismiss()
        }
    }
