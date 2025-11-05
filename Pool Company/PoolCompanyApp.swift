//
//  Pool_CompanyApp.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//

import SwiftUI

@main
struct PoolCompanyApp: App {
    init() {
            SampleData.loadSampleData()
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
