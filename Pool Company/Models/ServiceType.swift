//
//  ServiceType.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 05/10/25.
//


import Foundation

enum ServiceType: String, CaseIterable, Codable {
    case pool = "Pool"
    case extraYards = "Extra Yards"
    case spa = "SPA"
    case poolInfinity = "Pool Infinity"
    case spaInfinity = "SPA Infinity"
}