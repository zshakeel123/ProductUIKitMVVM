//
//  ProductListViewController.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 05/05/2025.
//

import UIKit
import Alamofire

// MARK: - Setup
class ProductListViewController: UITableViewController {
    private var viewModel: ProductListViewModel!
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Products"
        viewModel = ProductListViewModel()
        viewModel.output = self
        
        setupActivityIndicator()
            
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
        
        // Do any additional setup after loading the view.
        viewModel.loadProducts()
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - ProductList ViewModel Output Consumption
extension ProductListViewController: IProductListViewModelOutput {
    func productListDidUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func productListDidEncounterError(with error: any Error) {
        print("Error: \(error)")
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Something went wrong while fetching products.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    func productListLoadingStateDidChange(isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.activityIndicator.startAnimating()
                self.tableView.isUserInteractionEnabled = false
            } else {
                self.activityIndicator.stopAnimating()
                self.tableView.isUserInteractionEnabled = true
            }
        }
    }
}

// MARK: - TableView methods & Scrolling
extension ProductListViewController {
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height

        if offsetY > contentHeight - scrollViewHeight - 100 && !viewModel.isLoading { // Adjust the threshold as needed
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
        performSegue(withIdentifier: AppConstants.Segues.showProductDetailsSegueIdentifier, sender: selectedProduct)
            tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Navigation
extension  ProductListViewController {
    // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
       if segue.identifier == AppConstants.Segues.showProductDetailsSegueIdentifier {
           if let detailsVC = segue.destination as? ProductDetailsViewController,
              let selectedProduct = sender as? Product {
               detailsVC.product = selectedProduct
           }
       }
   }
}
