//
//  ProductTableViewCell.swift
//  ProductUIKitApp
//
//  Created by Zeeshan Shakeel on 19/05/2025.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Typography.title
        label.textColor = AppConstants.Color.primary
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppConstants.Typography.price
        label.textColor = AppConstants.Color.accent
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(productImageView)
        contentView.addSubview(textStackView)
        
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AppConstants.UI.defaultPadding),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            productImageView.widthAnchor.constraint(equalToConstant: 80),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            productImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -AppConstants.UI.defaultPadding / 2),
            // stack view constraints
            textStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: AppConstants.UI.defaultPadding),
            textStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AppConstants.UI.defaultPadding)
        ])
        
        backgroundColor = AppConstants.Color.cellBackground
        selectionStyle = .none
    }
    
    // MARK: - Configure Cell
    func configure(with product: Product){
        productImageView.kf.setImage(with: URL(string: product.thumbnail))
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
    }
}
