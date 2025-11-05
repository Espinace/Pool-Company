//
//  ProjectStatus.swift
//  Pool Company
//
//  Created by Bruno Amazonas Espinace on 26/09/25.
//

import Foundation

enum ProjectStatus: String, CaseIterable, Codable {
    case planning = "Planning"
    case inProgress = "In Progress"
    case completed = "Completed"
    case onHold = "On Hold"
}
