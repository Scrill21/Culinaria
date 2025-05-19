//
//  CuisineOptions.swift
//  Culinaria
//
//  Created by anthony byrd on 5/18/25.
//

import Foundation

enum CuisineOptions: CaseIterable, Identifiable {
    case all
    case american
    case british
    case canadian
    case croatian
    case french
    case greek
    case italian
    case malaysian
    case polish
    case portuguese
    case russian
    case tunisian
    
    var type: String {
        switch self {
            
        case .all: return "All"
        case .american: return "American"
        case .british: return "British"
        case .canadian: return "Canadian"
        case .croatian: return "Croatian"
        case .french: return "French"
        case .greek: return "Greek"
        case .italian: return "Italian"
        case .malaysian: return "Malaysian"
        case .polish: return "Polish"
        case .portuguese: return "Portuguese"
        case .russian: return "Russian"
        case .tunisian: return "Tunisian"
        }
    }
    
    var id: Self { return self }
}
