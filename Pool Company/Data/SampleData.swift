//
//  SampleData.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import Foundation

struct SampleData {
    static let sampleMaterials: [Material] = [
        Material(name: "Concrete", quantity: 20, unitCost: 150, supplier: "BuildCorp", isOrdered: true, deliveryDate: Date()),
        Material(name: "Pool Tiles", quantity: 500, unitCost: 12, supplier: "TileWorld", isOrdered: false, deliveryDate: nil),
        Material(name: "Pool Pump", quantity: 1, unitCost: 800, supplier: "PoolTech", isOrdered: true, deliveryDate: Date())
    ]
    
    static var employees: [Employee] = []
    static var services: [Service] = []
    static var projects: [Project] = []
    static var customers: [Customer] = []
    static var invoices: [Invoice] = []
    
    static func loadSampleData() {
        // Step 1: Crie projetos vazios (sem services ainda)
        let project1 = Project(
            name: "Luxury Backyard Pool",
            clientName: "Johnson Family",
            startDate: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
            expectedEndDate: Calendar.current.date(byAdding: .day, value: 20, to: Date())!,
            status: .inProgress,
            materials: sampleMaterials,
            services: [],
            totalCost: 45000,
            paidAmount: 15000
        )
        
        let project2 = Project(
            name: "Community Pool Renovation",
            clientName: "Sunset Community Center",
            startDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
            expectedEndDate: Calendar.current.date(byAdding: .day, value: 45, to: Date())!,
            status: .planning,
            materials: [],
            services: [],
            totalCost: 78000,
            paidAmount: 0
        )
        
        projects = [project1, project2]
        
        // Step 2: Crie os serviços
        let service1 = Service(
            type: .pool,
            projectId: project1.id,
            employeeIds: [], // vamos adicionar depois
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
            pricePerEmployee: 150,
            notes: "Pool installation completed",
            isCompleted: true
        )
        
        let service2 = Service(
            type: .spa,
            projectId: project1.id,
            employeeIds: [],
            date: Date(),
            pricePerEmployee: 200,
            notes: "SPA installation in progress",
            isCompleted: false
        )
        
        services = [service1, service2]
        
        // Step 3: Crie os funcionários agora que os services existem
        let employee1 = Employee(
            firstName: "Mike",
            lastName: "Johnson",
            email: "mike.johnson@poolcompany.com",
            phone: "(555) 123-4567",
            position: "Pool Installer",
            hireDate: Calendar.current.date(byAdding: .month, value: -6, to: Date())!,
            isActive: true,
            serviceRates: [
                EmployeeServiceRate(serviceType: .pool, rate: 150)
            ],
            completedServices: [service1.id]
        )
        
        let employee2 = Employee(
            firstName: "Sarah",
            lastName: "Wilson",
            email: "sarah.wilson@poolcompany.com",
            phone: "(555) 987-6543",
            position: "Plumber Specialist",
            hireDate: Calendar.current.date(byAdding: .month, value: -12, to: Date())!,
            isActive: true,
            serviceRates: [
                EmployeeServiceRate(serviceType: .spa, rate: 200)
            ],
            completedServices: [service1.id]
        )
        
        let employee3 = Employee(
            firstName: "Carlos",
            lastName: "Rodriguez",
            email: "carlos.rodriguez@poolcompany.com",
            phone: "(555) 456-7890",
            position: "Tile Specialist",
            hireDate: Calendar.current.date(byAdding: .month, value: -18, to: Date())!,
            isActive: true,
            serviceRates: [
                EmployeeServiceRate(serviceType: .spa, rate: 200)
            ],
            completedServices: [service2.id]
        )
        
        employees = [employee1, employee2, employee3]
        
        // Step 4: Atualize os serviços com os funcionários
        services[0].employeeIds = [employee1.id, employee2.id]
        services[1].employeeIds = [employee3.id]
        
        // Step 5: Atualize os projetos com os serviços
        projects[0].services = [service1.id, service2.id]
        
        // Step 6: Clientes
        customers = [
            Customer(
                firstName: "Robert",
                lastName: "Johnson",
                email: "robert.johnson@email.com",
                phone: "(555) 111-2222",
                address: CustomerAddress(
                    street: "123 Maple Street",
                    city: "Beverly Hills",
                    state: "CA",
                    zipCode: "90210",
                    country: "USA"
                ),
                projects: [project1.id],
                notes: "VIP customer, prefers morning calls",
                registrationDate: Calendar.current.date(byAdding: .month, value: -2, to: Date())!,
                preferredContactMethod: .phone
            )
        ]
        
        // Step 7: Faturas
        invoices = [
            Invoice(
                invoiceNumber: "INV-001",
                projectId: project1.id,
                amount: 15000,
                issueDate: Calendar.current.date(byAdding: .day, value: -15, to: Date())!,
                dueDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                status: .paid,
                description: "Initial payment for pool construction"
            )
        ]
    }
}
