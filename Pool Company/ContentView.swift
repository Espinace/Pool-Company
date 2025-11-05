//
//  ContentView.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ExecutionMaterialsView()
                .tabItem {
                    Image(systemName: "hammer.fill")
                    Text("Execution & Materials")
                }
                .tag(0)
            
            ServicesView()
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("Services")
                }
                .tag(1)
            
            PeopleView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("People")
                }
                .tag(2)
            
            FinancesView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Finances")
                }
                .tag(3)
        }
        .accentColor(.blue)
    }
}

#Preview {
    ContentView()
}
