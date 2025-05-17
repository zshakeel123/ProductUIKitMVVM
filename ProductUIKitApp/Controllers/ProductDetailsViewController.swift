//
//  ProductDetailsViewController.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 06/05/2025.
//

import UIKit
import Kingfisher

class ProductDetailsViewController: UIViewController {
    
    var product: Product?
    private var viewModel: ProductDetailsViewModel!
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let product = self.product else { return }
        
        viewModel = ProductDetailsViewModel(product: product)
        configureViews()
    }
    
    func configureViews() {
        title = viewModel.title
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        priceLabel.text = "\(viewModel.price)"
        
        productImageView.kf.setImage(with: viewModel.thumbnailURL)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
