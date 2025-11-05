//
//  DataManager.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import Foundation
import Combine

class DataManager: ObservableObject {
    // MARK: - Published Properties
    @Published var projects: [Project] = []
    @Published var employees: [Employee] = []
    @Published var customers: [Customer] = []
    @Published var invoices: [Invoice] = []
    @Published var services: [Service] = [] // ADD THIS
    
    // MARK: - Private Properties
    private let userDefaults = UserDefaults.standard
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Singleton
    static let shared = DataManager()
    
    private init() {
        loadData()
        setupDataObservers()
    }
    
    // MARK: - Data Loading
    private func loadData() {
        projects = SampleData.projects
        employees = SampleData.employees
        customers = SampleData.customers
        invoices = SampleData.invoices
        services = SampleData.services // ADD THIS
    }
    
    // MARK: - Data Observers
    private func setupDataObservers() {
        $projects
            .dropFirst()
            .sink { [weak self] _ in
                self?.saveProjects()
            }
            .store(in: &cancellables)
        
        $employees
            .dropFirst()
            .sink { [weak self] _ in
                self?.saveEmployees()
            }
            .store(in: &cancellables)
        
        $customers
            .dropFirst()
            .sink { [weak self] _ in
                self?.saveCustomers()
            }
            .store(in: &cancellables)
        
        $invoices
            .dropFirst()
            .sink { [weak self] _ in
                self?.saveInvoices()
            }
            .store(in: &cancellables)
        
        $services
            .dropFirst()
            .sink { [weak self] _ in
                self?.saveServices()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Service Operations
    func addService(_ service: Service) {
        services.append(service)
    }
    
    func updateService(_ service: Service) {
        if let index = services.firstIndex(where: { $0.id == service.id }) {
            services[index] = service
        }
    }
    
    func deleteService(withId id: UUID) {
        services.removeAll { $0.id == id }
    }
    
    // MARK: - Project Operations
    func addProject(_ project: Project) {
        projects.append(project)
        NotificationCenter.default.post(name: AppConstants.Notifications.projectUpdated, object: project)
    }
    
    func updateProject(_ project: Project) {
        if let index = projects.firstIndex(where: { $0.id == project.id }) {
            projects[index] = project
            NotificationCenter.default.post(name: AppConstants.Notifications.projectUpdated, object: project)
        }
    }
    
    func deleteProject(withId id: UUID) {
        projects.removeAll { $0.id == id }
    }
    
    func getProject(withId id: UUID) -> Project? {
        return projects.first { $0.id == id }
    }
    
    // MARK: - Employee Operations
    func addEmployee(_ employee: Employee) {
        employees.append(employee)
        NotificationCenter.default.post(name: AppConstants.Notifications.employeeUpdated, object: employee)
    }
    
    func updateEmployee(_ employee: Employee) {
        if let index = employees.firstIndex(where: { $0.id == employee.id }) {
            employees[index] = employee
            NotificationCenter.default.post(name: AppConstants.Notifications.employeeUpdated, object: employee)
        }
    }
    
    func deleteEmployee(withId id: UUID) {
        employees.removeAll { $0.id == id }
    }
    
    func getActiveEmployees() -> [Employee] {
        return employees.filter { $0.isActive }
    }
    
    // MARK: - Customer Operations
    func addCustomer(_ customer: Customer) {
        customers.append(customer)
        NotificationCenter.default.post(name: AppConstants.Notifications.customerUpdated, object: customer)
    }
    
    func updateCustomer(_ customer: Customer) {
        if let index = customers.firstIndex(where: { $0.id == customer.id }) {
            customers[index] = customer
            NotificationCenter.default.post(name: AppConstants.Notifications.customerUpdated, object: customer)
        }
    }
    
    func deleteCustomer(withId id: UUID) {
        customers.removeAll { $0.id == id }
    }
    
    func getCustomer(withId id: UUID) -> Customer? {
        return customers.first { $0.id == id }
    }
    
    // MARK: - Invoice Operations
    func addInvoice(_ invoice: Invoice) {
        invoices.append(invoice)
        NotificationCenter.default.post(name: AppConstants.Notifications.invoiceUpdated, object: invoice)
    }
    
    func updateInvoice(_ invoice: Invoice) {
        if let index = invoices.firstIndex(where: { $0.id == invoice.id }) {
            invoices[index] = invoice
            NotificationCenter.default.post(name: AppConstants.Notifications.invoiceUpdated, object: invoice)
        }
    }
    
    func deleteInvoice(withId id: UUID) {
        invoices.removeAll { $0.id == id }
    }
    
    func getUnpaidInvoices() -> [Invoice] {
        return invoices.filter { $0.status != .paid }
    }
    
    func getPaidInvoices() -> [Invoice] {
        return invoices.filter { $0.status == .paid }
    }
    
    // MARK: - Analytics
    func getTotalRevenue() -> Double {
        return getPaidInvoices().reduce(0) { $0 + $1.amount }
    }
    
    func getPendingRevenue() -> Double {
        return getUnpaidInvoices().reduce(0) { $0 + $1.amount }
    }
    
    func getWeeklyPayroll() -> Double {
        return employees.reduce(0) { $0 + $1.weeklyEarnings(from: services) } // FIX
    }
    
    func getActiveProjectsCount() -> Int {
        return projects.filter { $0.status == .inProgress }.count
    }
    
    func getActiveEmployeesCount() -> Int {
        return employees.filter { $0.isActive }.count
    }
    
    // MARK: - Data Persistence
    private func saveProjects() {
        print("Projects saved: \(projects.count)")
    }
    
    private func saveEmployees() {
        print("Employees saved: \(employees.count)")
    }
    
    private func saveCustomers() {
        print("Customers saved: \(customers.count)")
    }
    
    private func saveInvoices() {
        print("Invoices saved: \(invoices.count)")
    }
    
    private func saveServices() {
        print("Services saved: \(services.count)")
    }
    
    // MARK: - Data Export/Import
    func exportData() -> Bool {
        NotificationCenter.default.post(name: AppConstants.Notifications.dataExported, object: nil)
        return true
    }
    
    func importData(from url: URL) -> Bool {
        NotificationCenter.default.post(name: AppConstants.Notifications.dataImported, object: nil)
        return true
    }
    
    // MARK: - Search and Filter
    func searchProjects(query: String) -> [Project] {
        guard !query.isEmpty else { return projects }
        return projects.filter {
            $0.name.localizedCaseInsensitiveContains(query) ||
            $0.clientName.localizedCaseInsensitiveContains(query)
        }
    }
    
    func searchEmployees(query: String) -> [Employee] {
        guard !query.isEmpty else { return employees }
        return employees.filter {
            $0.fullName.localizedCaseInsensitiveContains(query) ||
            $0.position.localizedCaseInsensitiveContains(query)
        }
    }
    
    func searchCustomers(query: String) -> [Customer] {
        guard !query.isEmpty else { return customers }
        return customers.filter {
            $0.fullName.localizedCaseInsensitiveContains(query) ||
            $0.email.localizedCaseInsensitiveContains(query)
        }
    }
}
