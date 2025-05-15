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
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        
        configureViews()
    }
    
    func configureViews() {
        guard let product = self.product else { return }
        
        title = product.title
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        priceLabel.text = "$\(product.price)"
        
        productImageView.kf.setImage(with: URL(string: product.thumbnail))
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
