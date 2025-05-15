//
//  ProductListViewModel.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 15/05/2025.
//

import Foundation


class ProductListViewModel {
    private let productService: IProductService
    private var products: [Product] = []
    private var currentPage = 0
    private let limit = 10
    private var isLoading = false
    
    var onProductsUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(productService: IProductService = ProductService()) {
        self.productService = productService
    }
    
    var displayedProducts: [Product] {
        return products
    }
    
    func loadProducts() {
        guard !isLoading else {return}
        isLoading = true
        
        let skipValue = currentPage * limit
        
        productService.fetchProducts(skip: skipValue, limit: limit) { [weak self] result in
            guard let self = self else {return}
            self.isLoading = false
            
            switch result {
            case .success(let productResponse):
                self.products.append(contentsOf: productResponse.products)
                self.currentPage += 1
                self.onProductsUpdated?()
            case .failure(let error):
                self.onError?(error)
            }
        }
    }
    
    func loadMoreProducts() {
        loadProducts()
    }
    
    func product(at index: Int) -> Product? {
        guard index >= 0 && index < products.count else { return nil }

        return products[index]
    }
    
    var numberOfProducts: Int {
        return products.count
    }
}
