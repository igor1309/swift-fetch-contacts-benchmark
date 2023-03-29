//
//  ContentViewModel.swift
//  ContactFetchApp
//
//  Created by Igor Malyarov on 29.03.2023.
//

import Foundation

final class ContentViewModel: ObservableObject {
    
    @Published private(set) var duration: TimeInterval?
    @Published var keys: ContactKeys = .identifiers
    
    init() {
        
        $keys
            .map { _ in Double?.none }
            .assign(to: &$duration)
    }
    
    func fetchContactsButtonTapped() {
        
        duration = 10
    }
}
