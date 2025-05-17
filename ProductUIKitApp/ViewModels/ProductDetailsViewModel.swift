//
//  ProductDetailsViewModel.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 17/05/2025.
//

import Foundation

class ProductDetailsViewModel {
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var title: String {
        product.title
    }
    
    var description: String {
        product.description
    }
    
    var price: String {
        String(format: "$ %.2f", product.price)
    }
    
    var thumbnailURL: URL? {
        URL(string: product.thumbnail)
    }
}
