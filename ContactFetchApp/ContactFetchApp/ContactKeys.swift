//
//  ContactKeys.swift
//  ContactFetchApp
//
//  Created by Igor Malyarov on 29.03.2023.
//

import Contacts

enum ContactKeys: String, CaseIterable {
    
    case identifiers, identifiersAndNumbers, manyFields
    
    var cnKeyDescriptors: [CNKeyDescriptor] {
        
        switch self {
            
        case .identifiers:
            return .identifiers
        case .identifiersAndNumbers:
            return .identifiersAndNumbers
        case .manyFields:
            return .manyFields
        }
    }
}

private extension Array where Element == CNKeyDescriptor {
    
    static let identifiers = [
        CNContactIdentifierKey,
    ] as [CNKeyDescriptor]
    
    static let identifiersAndNumbers = [
        CNContactIdentifierKey,
        CNContactPhoneNumbersKey,
    ] as [CNKeyDescriptor]
    
    static let manyFields = [
        CNContactPhoneNumbersKey,
        CNContactGivenNameKey,
        CNContactMiddleNameKey,
        CNContactFamilyNameKey,
        CNContactImageDataAvailableKey,
        CNContactThumbnailImageDataKey
    ] as [CNKeyDescriptor]
}
