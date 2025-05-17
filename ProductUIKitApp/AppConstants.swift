//
//  AppConstants.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 17/05/2025.
//

import Foundation

// MARK: - App Constants (Enum for name spacing)
enum AppConstants {
    // MARK: - API
    enum API {
        static let baseURLString = "https://dummyjson.com"
        static let productsEndpoint = "/products"
        static let usersEndpoint = "/users"
        // ... other API endpoints
    }
    
    // MARK: - UI
    enum UI {
        static let defaultPadding: CGFloat = 16.0
        static let animationDuration: TimeInterval = 0.3
    }
    
    // MARK: - Segues
    enum Segues {
        static let showProductDetailsSegueIdentifier = "showProductDetailsSegue"
    }
    
    // MARK: - Other
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    static let supportEmail = "support@yourapp.com"
}
