//
//  ProductListViewController.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 05/05/2025.
//

import UIKit
import Alamofire

class ProductListViewController: UITableViewController {
    private var viewModel: ProductListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Products"
        viewModel = ProductListViewModel()
        
        viewModel.onError = { error in
            print("Error: \(error)")
        }
        
        viewModel.onProductsUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
        
        // Do any additional setup after loading the view.
        viewModel.loadProducts()
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height

        if offsetY > contentHeight - scrollViewHeight - 100 { // Adjust the threshold as needed
            viewModel.loadMoreProducts()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfProducts
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        if let product = viewModel.product(at: indexPath.row) {
            cell.textLabel?.text = product.title
            cell.detailTextLabel?.text = "\(product.price)"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedProduct = products[indexPath.row]
//        let detailsVC = ProductDetailsViewController()
//        detailsVC.product = selectedProduct
//        navigationController?.pushViewController(detailsVC, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedProduct = viewModel.product(at: indexPath.row)
            performSegue(withIdentifier: "PDSegue", sender: selectedProduct)
            tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PDSegue" {
            if let detailsVC = segue.destination as? ProductDetailsViewController,
               let selectedProduct = sender as? Product {
                detailsVC.product = selectedProduct
            }
        }
    }
     
    
}
