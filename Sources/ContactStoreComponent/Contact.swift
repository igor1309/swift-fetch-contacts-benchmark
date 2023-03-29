//
//  Contact.swift
//  
//
//  Created by Igor Malyarov on 29.03.2023.
//

import Contacts
import Foundation

struct Contact {
    
    typealias ID = String // better would be Tagged<Self, String>
    
    var id: String { phone }
    let phone: String
    let firstName: String?
    let middleName: String?
    let lastName: String?
    let avatar: ImageData?
}

extension Contact {
    
    enum SortOrder {
        
        /// No sorting order.
        case none
        
        /// The user’s default sorting order.
        case userDefault
        
        /// Sorting contacts by given name.
        case givenName
        
        /// Sorting contacts by family name.
        case familyName
    }
}

extension Contact.SortOrder {
    
    var cnContactSortOrder: CNContactSortOrder {
        
        switch self {
            
        case .none:        return .none
        case .userDefault: return .userDefault
        case .givenName:   return .givenName
        case .familyName:  return .familyName
        }
    }
}

extension Contact {
    
    init?(with cnContact: CNContact) {
        
        guard
            let phoneNumberData = cnContact.phoneNumbers.first?.value as? CNPhoneNumber,
            let phoneNumber = phoneNumberData.value(forKey: "digits") as? String
        else {
            return nil
        }
        
        self.init(
            phone: phoneNumber,
            firstName: cnContact.givenName,
            middleName: cnContact.middleName,
            lastName: cnContact.familyName,
            avatar: Self.avatar(for: cnContact)
        )
    }
    
    private static func avatar(for cnContact: CNContact) -> ImageData? {
        
        guard let thumbnailImageData = cnContact.thumbnailImageData
        else { return nil }
        
        return ImageData(data: thumbnailImageData)
        
    }
}

struct ImageData: Codable, Equatable {
    
    let data: Data
}
