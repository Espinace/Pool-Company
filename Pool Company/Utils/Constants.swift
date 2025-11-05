//
//  Constants.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import Foundation
import SwiftUI

struct AppConstants {
    
    // MARK: - App Information
    struct App {
        static let name = "Pool Company"
        static let version = "1.0.0"
        static let bundleIdentifier = "com.poolcompany.app"
    }
    
    // MARK: - UI Constants
    struct UI {
        // Spacing
        static let smallSpacing: CGFloat = 8
        static let mediumSpacing: CGFloat = 16
        static let largeSpacing: CGFloat = 24
        static let extraLargeSpacing: CGFloat = 32
        
        // Corner Radius
        static let smallCornerRadius: CGFloat = 8
        static let mediumCornerRadius: CGFloat = 12
        static let largeCornerRadius: CGFloat = 16
        
        // Padding
        static let smallPadding: CGFloat = 8
        static let mediumPadding: CGFloat = 16
        static let largePadding: CGFloat = 24
        
        // Shadow
        static let shadowRadius: CGFloat = 4
        static let shadowOpacity: Double = 0.1
    }
    
    // MARK: - Business Constants
    struct Business {
        // Work Hours
        static let standardWorkHoursPerDay: Double = 8.0
        static let maxWorkHoursPerDay: Double = 12.0
        static let standardWorkDaysPerWeek: Int = 5
        
        // Currency
        static let currencySymbol = "$"
        static let currencyCode = "USD"
        
        // Project Defaults
        static let defaultProjectDurationDays = 30
        static let minimumProjectValue: Double = 1000.0
        
        // Employee Defaults
        static let minimumDailyRate: Double = 100.0
        static let maximumDailyRate: Double = 500.0
    }
    
    // MARK: - Colors
    struct Colors {
        // Status Colors
        static let planning = Color.orange
        static let inProgress = Color.blue
        static let completed = Color.green
        static let onHold = Color.red
        
        // Invoice Status Colors
        static let draft = Color.gray
        static let sent = Color.blue
        static let paid = Color.green
        static let overdue = Color.red
        
        // General Colors
        static let success = Color.green
        static let warning = Color.orange
        static let error = Color.red
        static let info = Color.blue
        
        // Background Colors
        static let primaryBackground = Color(.systemBackground)
        static let secondaryBackground = Color(.secondarySystemBackground)
        static let groupedBackground = Color(.systemGroupedBackground)
    }
    
    // MARK: - SF Symbols
    struct Icons {
        // Tab Icons
        static let execution = "hammer.fill"
        static let processSteps = "list.number"
        static let people = "person.2.fill"
        static let finances = "dollarsign.circle.fill"
        
        // General Icons
        static let add = "plus"
        static let edit = "pencil"
        static let delete = "trash"
        static let save = "checkmark"
        static let cancel = "xmark"
        
        // Status Icons
        static let completed = "checkmark.circle.fill"
        static let pending = "clock.circle"
        static let active = "circle.fill"
        static let inactive = "circle"
        
        // Business Icons
        static let project = "building"
        static let material = "cube.box"
        static let employee = "person"
        static let customer = "person.circle"
        static let invoice = "doc.text"
        static let report = "chart.bar"
        static let calendar = "calendar"
        static let phone = "phone"
        static let email = "envelope"
    }
    
    // MARK: - User Defaults Keys
    struct UserDefaultsKeys {
        static let hasLaunchedBefore = "hasLaunchedBefore"
        static let lastBackupDate = "lastBackupDate"
        static let selectedCurrency = "selectedCurrency"
        static let notificationsEnabled = "notificationsEnabled"
        static let darkModeEnabled = "darkModeEnabled"
    }
    
    // MARK: - Notification Names
    struct Notifications {
        static let projectUpdated = NSNotification.Name("ProjectUpdated")
        static let employeeUpdated = NSNotification.Name("EmployeeUpdated")
        static let customerUpdated = NSNotification.Name("CustomerUpdated")
        static let invoiceUpdated = NSNotification.Name("InvoiceUpdated")
        static let dataImported = NSNotification.Name("DataImported")
        static let dataExported = NSNotification.Name("DataExported")
    }
}
