//
//  ProductListViewModelTests.swift
//  ProductUIKitAppTests
//
//  Created by Zeeshan Shakeel on 15/05/2025.
//

import XCTest
import Alamofire

@testable import ProductUIKitApp

// MARK: - MockProductService
class MockProductService: IProductService {
    var mockResult: Result<ProductResponse, AFError>!
    
    func fetchProducts(skip: Int, limit: Int, completion: @escaping (Result<ProductUIKitApp.ProductResponse, AFError>) -> Void) {
        
        completion(mockResult)
    }
}

// MARK: - MockProductListViewModelOutput
class MockProductListViewModelOutput: IProductListViewModelOutput {
    var didUpdateProducts = false
    var receivedError: Error?
    var loadingStates: [Bool] = []
    
    // Expectations for asynchronous calls
    var updateExpectation: XCTestExpectation?
    var errorExpectation: XCTestExpectation?
    var loadingStateExpectation: XCTestExpectation?
    
    func productListDidUpdate() {
        didUpdateProducts = true
        updateExpectation?.fulfill()
    }
    
    func productListDidEncounterError(with error: any Error) {
        receivedError = error
        errorExpectation?.fulfill()
    }
    
    func productListLoadingStateDidChange(isLoading: Bool) {
        loadingStates.append(isLoading)
        loadingStateExpectation?.fulfill()
    }
}

// MARK: - ProductListViewModelTests
class ProductListViewModelTests: XCTestCase {
    var viewModel: ProductListViewModel!
    var mockService: MockProductService!
    var mockOutput: MockProductListViewModelOutput!
    
    override func setUp() {
        super.setUp()
        mockService = MockProductService()
        mockOutput = MockProductListViewModelOutput()
        viewModel = ProductListViewModel(productService: mockService, output: mockOutput)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockOutput = nil
        super.tearDown()
    }
    
    func testLoadProductsSuccess() {
        // Arrange
        let expectation  = XCTestExpectation(description: "Products loaded successfully")
        mockOutput.updateExpectation = expectation
        
        let mockProducts = [
            Product(id: 1, title: "Test Product 1", description: "", price: 10, discountPercentage: 0, rating: 5, stock: 0, brand: nil, category: "", thumbnail: "", images: []),
            Product(id: 2, title: "Test Product 2", description: "", price: 20, discountPercentage: 0, rating: 5, stock: 0, brand: nil, category: "", thumbnail: "", images: [])
        ]
        
        mockService.mockResult = .success(ProductResponse(products: mockProducts, total: 2, skip: 0, limit: 10))
        
        // Act
        viewModel.loadProducts()
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockOutput.didUpdateProducts)
        XCTAssertTrue(self.viewModel.numberOfProducts == 2)
        XCTAssertEqual(self.viewModel.product(at: 0)?.title, "Test Product 1")
        XCTAssertEqual(self.viewModel.product(at: 1)?.title, "Test Product 2")
    }
    
    func testLoadFailure() {
        // Arrange
        let expectation = XCTestExpectation(description: "Products failed to load")
        mockOutput.errorExpectation = expectation
        
        let mockError = AFError.sessionTaskFailed(error: NSError(domain: "TestErrorDomain", code: 123, userInfo: nil))
        mockService.mockResult = .failure(mockError)
        
        // Act
        viewModel.loadProducts()
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(mockOutput.receivedError)
    }
    
    func testDisplayedProductsReflectLoadedProducts() {
        // Arrange
        let expectation  = XCTestExpectation(description: "Displayed products updated")
        mockOutput.updateExpectation = expectation
        
        let mockProducts = [
            Product(id: 3, title: "Test Product 3", description: "", price: 30, discountPercentage: 0, rating: 0, stock: 0, brand: nil, category: "", thumbnail: "", images: [])
        ]
        
        let mockResponse = ProductResponse(products: mockProducts, total: 1, skip: 0, limit: 10)
        mockService.mockResult = .success(mockResponse)
        
        // Act
        viewModel.loadProducts()
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(self.viewModel.displayedProducts.count, 1)
        XCTAssertEqual(self.viewModel.displayedProducts[0].id, 3)
    }
    
    func testLoadingStateChanges() {
        // Arrange
        // We expect two loading state changes: true (start) and false (end)
        let loadingExpectation = XCTestExpectation(description: "Loading state updated twice")
        loadingExpectation.expectedFulfillmentCount = 2
        mockOutput.loadingStateExpectation = loadingExpectation
        
        let updateExpectation = XCTestExpectation(description: "Products updated after loading")
        mockOutput.updateExpectation = updateExpectation
        
        let mockProducts = [
            Product(id: 1, title: "Loading Test Product", description: "", price: 1, discountPercentage: 0, rating: 5, stock: 0, brand: nil, category: "", thumbnail: "", images: [])
        ]
        
        mockService.mockResult = .success(ProductResponse(products: mockProducts, total: 1, skip: 0, limit: 10))
        
        // Act
        viewModel.loadProducts()
        
        // Assert
        wait(for: [loadingExpectation, updateExpectation], timeout: 2.0)
        XCTAssertEqual(mockOutput.loadingStates.count, 2)
        XCTAssertEqual(mockOutput.loadingStates[0], true, "Loading should start as true")
        XCTAssertEqual(mockOutput.loadingStates[1], false, "Loading should end as false")
        XCTAssertFalse(viewModel.isLoading, "ViewModel's isLoading should be false after completion")
    }
}
