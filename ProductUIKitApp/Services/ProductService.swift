//
//  ProductService.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 15/05/2025.
//

import Foundation
import Alamofire

protocol IProductService {
    func fetchProducts(skip: Int, limit: Int, completion: @escaping (Result<ProductResponse, AFError>) -> Void)
    
}

class ProductService: IProductService {
    
    func fetchProducts(skip: Int, limit: Int, completion: @escaping (Result<ProductResponse, AFError>) -> Void) {
        //let urlString = "https://dummyjson.com/products?skip=\(skip)&limit=\(limit)"
        let urlString = "\(AppConstants.API.baseURLString)\(AppConstants.API.productsEndpoint)?skip=\(skip)&limit=\(limit)"
        
        AF.request(urlString).responseDecodable(of: ProductResponse.self) { response in
            completion(response.result)
        }
    }
}
