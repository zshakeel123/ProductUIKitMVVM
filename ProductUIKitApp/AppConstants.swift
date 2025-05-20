//
//  AppConstants.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 17/05/2025.
//

import Foundation
import UIKit

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
    
    enum Color {
        static let primary = UIColor(named: "PrimaryColor") ?? UIColor.systemBlue
        static let secondary = UIColor(named: "SecondaryColor") ?? UIColor.secondaryLabel
        static let accent = UIColor(named: "AccentColor") ?? UIColor.systemOrange
        static let background = UIColor(named: "BackgroundColor") ?? UIColor.systemBackground
        static let cellBackground = UIColor(named: "CellBackgroundColor") ?? UIColor.white
    }
    
    enum Typography {
        static let title = UIFont.systemFont(ofSize: 18, weight: .semibold)
        static let price = UIFont.systemFont(ofSize: 18, weight: .bold)
        // Removed 'body' as description label is removed from cell
    }
    
    // MARK: - Other
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    static let supportEmail = "support@yourapp.com"
}
