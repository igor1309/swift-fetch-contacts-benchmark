//
//  ContentViewModel.swift
//  ContactFetchApp
//
//  Created by Igor Malyarov on 29.03.2023.
//

import ContactStoreComponent
import Foundation

final class ContentViewModel: ObservableObject {
    
    @Published private(set) var duration: TimeInterval?
    @Published var keys: ContactKeys = .identifiers
    
    private let store: ContactStore
    
    init(store: ContactStore = .init()) {
        
        self.store = store
        
        $keys
            .map { _ in Double?.none }
            .receive(on: DispatchQueue.main)
            .assign(to: &$duration)
    }
    
    func fetchContactsButtonTapped() {
        
        Task {
            
            store
        }
    }
}
