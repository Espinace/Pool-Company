//
//  Material.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 23/09/25.
//
import Foundation

struct Material: Identifiable, Codable {
    let id = UUID()
    var name: String
    var quantity: Int
    var unitCost: Double
    var supplier: String
    var isOrdered: Bool
    var deliveryDate: Date?
    
    var totalCost: Double {
        return Double(quantity) * unitCost
    }
}
