//
//  ProductListViewModelTests.swift
//  ProductUIKitAppTests
//
//  Created by Zeeshan Shakeel on 15/05/2025.
//

import XCTest
import Alamofire

@testable import ProductUIKitApp

class MockProductService: IProductService {
    var mockResult: Result<ProductResponse, AFError>!
    
    func fetchProducts(skip: Int, limit: Int, completion: @escaping (Result<ProductUIKitApp.ProductResponse, AFError>) -> Void) {
        
        completion(mockResult)
    }
}


class ProductListViewModelTests: XCTestCase {
    var viewModel: ProductListViewModel!
    var mockService: MockProductService!
    
    override func setUp() {
        super.setUp()
        mockService = MockProductService()
        viewModel = ProductListViewModel(productService: mockService)
    }
    
    func testLoadProductsSuccess() {
        // Arrange
        let expectation  = XCTestExpectation(description: "Products loaded successfully")
        let mockProducts = [
            Product(id: 1, title: "Test Product 1", description: "", price: 10, discountPercentage: 0, rating: 5, stock: 0, brand: nil, category: "", thumbnail: "", images: []),
            Product(id: 2, title: "Test Product 2", description: "", price: 20, discountPercentage: 0, rating: 5, stock: 0, brand: nil, category: "", thumbnail: "", images: [])
        ]
        
        mockService.mockResult = .success(ProductResponse(products: mockProducts, total: 2, skip: 0, limit: 10))
        
        // Assert
        viewModel.onProductsUpdated = {
            XCTAssertTrue(self.viewModel.numberOfProducts == 2)
            XCTAssertEqual(self.viewModel.product(at: 0)?.title, "Test Product 1")
            XCTAssertEqual(self.viewModel.product(at: 1)?.title, "Test Product 2")
            expectation.fulfill()
        }
        
        // Act
        viewModel.loadProducts()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadFailure() {
        // Arrange
        let expectation  = XCTestExpectation(description: "Products failed to load")
        let mockError = AFError.sessionTaskFailed(error: NSError(domain: "", code: 123, userInfo: nil))
        mockService.mockResult = .failure(mockError)
        
        // Assert
        viewModel.onError = { error in
            if case let AFError.sessionTaskFailed(err) = error {
                print(err)
            }
            
            expectation.fulfill()
        }
        
        // Act
        viewModel.loadProducts()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testDisplayedProductsReflectLoadedProducts() {
        // Arrange
        let mockProducts = [
            Product(id: 3, title: "Test Product 3", description: "", price: 30, discountPercentage: 0, rating: 0, stock: 0, brand: nil, category: "", thumbnail: "", images: [])
        ]
        
        let mockResponse = ProductResponse(products: mockProducts, total: 1, skip: 0, limit: 10)
        mockService.mockResult = .success(mockResponse)
        
        // Assert
        let expectation  = XCTestExpectation(description: "Displayed products updated")
        
        viewModel.onProductsUpdated = {
            XCTAssertEqual(self.viewModel.displayedProducts.count, 1)
            XCTAssertEqual(self.viewModel.displayedProducts[0].id, 3)
            expectation.fulfill()
        }
        
        // Act
        viewModel.loadProducts()
        wait(for: [expectation], timeout: 1.0)
    }
}
