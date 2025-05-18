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
    
    // MARK: - New UI Elements
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var contentStackView: UIStackView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let product = self.product else { return }
        
        viewModel = ProductDetailsViewModel(product: product)
        
        configureViews()
    }
    
    func configureViews() {
        guard let product = self.product else { return }
        
        title = viewModel.title
        
        productImageView.kf.setImage(with: viewModel.thumbnailURL)
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = AppConstants.UI.defaultPadding
        productImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        titleLabel.text = viewModel.title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1) // Dynamic Type support
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0 // Allow multiple lines for long titles
        titleLabel.textColor = .label // Adapts to Dark Mode
        
        priceLabel.text = viewModel.price
        priceLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        priceLabel.textColor = .systemGreen // A common color for price
        
        descriptionLabel.text = viewModel.description
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .secondaryLabel
        
        brandLabel.text = viewModel.brand
        brandLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        brandLabel.textColor = .tertiaryLabel
        
        categoryLabel.text = viewModel.category
        categoryLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        categoryLabel.textColor = .tertiaryLabel
        
        stockLabel.text = viewModel.stock
        stockLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        stockLabel.textColor = product.stock > 0 ? .systemGreen : .systemRed
        
        ratingLabel.text = viewModel.rating
        ratingLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        ratingLabel.textColor = .systemOrange
        
        if let stackView = contentStackView {
            stackView.spacing = AppConstants.UI.defaultPadding / 2
            stackView.layoutMargins = UIEdgeInsets(top: AppConstants.UI.defaultPadding,
                                                   left: AppConstants.UI.defaultPadding,
                                                   bottom: AppConstants.UI.defaultPadding,
                                                   right: AppConstants.UI.defaultPadding)
            stackView.isLayoutMarginsRelativeArrangement = true
        }
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
