//
//  ProductListViewModel.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 15/05/2025.
//

import Foundation

protocol IProductListViewModelOutput: AnyObject {
    func productListDidUpdate()
    func productListDidEncounterError(with error: Error)
    func productListLoadingStateDidChange(isLoading: Bool)
}

class ProductListViewModel {
    private let productService: IProductService
    private var products: [Product] = []
    private var currentPage = 0
    private let limit = 10
    private var _isLoading = false
    
    // MARK: - Output Delegate
    weak var output: IProductListViewModelOutput?
    
    init(productService: IProductService = ProductService(), output: IProductListViewModelOutput? = nil) {
        self.productService = productService
        self.output = output
    }
    
    var displayedProducts: [Product] {
        return products
    }
    
    var isLoading: Bool {
        return _isLoading
    }
    
    func loadProducts() {
        guard !_isLoading else {return}
        _isLoading = true
        output?.productListLoadingStateDidChange(isLoading: _isLoading)
        
        let skipValue = currentPage * limit
        
        productService.fetchProducts(skip: skipValue, limit: limit) { [weak self] result in
            guard let self = self else {return}
            self._isLoading = false
            self.output?.productListLoadingStateDidChange(isLoading: _isLoading)
            
            switch result {
            case .success(let productResponse):
                self.products.append(contentsOf: productResponse.products)
                self.currentPage += 1
                self.output?.productListDidUpdate()
                
            case .failure(let error):
                self.output?.productListDidEncounterError(with: error)
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
