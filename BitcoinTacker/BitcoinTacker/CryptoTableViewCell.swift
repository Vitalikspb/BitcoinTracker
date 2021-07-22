//
//  CryptoTableViewCell.swift
//  BitcoinTacker
//
//  Created by VITALIY SVIRIDOV on 21.07.2021.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "CryptoTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.frame.size.height / 1.1
        
        nameLabel.sizeToFit()
        priceLabel.sizeToFit()
        symbolLabel.sizeToFit()
        
        myImageView.frame = CGRect(
            x: 25,
            y: (contentView.frame.size.height - size) / 2,
            width: size,
            height: size)
        
        nameLabel.frame = CGRect(x: 30 + size,
                                 y: 0,
                                 width: contentView.frame.size.width / 2,
                                 height: contentView.frame.size.height / 2)
        symbolLabel.frame = CGRect(x: 30 + size,
                                   y: contentView.frame.size.height / 2,
                                   width: contentView.frame.size.width / 2,
                                   height: contentView.frame.size.height / 2)
        priceLabel.frame = CGRect(x: contentView.frame.size.width / 2,
                                  y: 0,
                                  width: (contentView.frame.size.width / 2) - 15,
                                  height: contentView.frame.size.height)
        
    }
    
    // MARK: - Helper Functions
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
        nameLabel.text = nil
        priceLabel.text = nil
        symbolLabel.text = nil
    }
    
    func configure(with viewModel: CryptoTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        symbolLabel.text = viewModel.symbol
        priceLabel.text = viewModel.price
        
        if let url = viewModel.iconUrl {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                if let data = viewModel.iconData {
                    self?.updateImage(with: data)
                } else {
                    if let data = data {
                        viewModel.iconData = data
                        self?.updateImage(with: data)
                    }
                }
            }
            task.resume()
        }
    }
    
    func updateImage(with data: Data) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.myImageView.image = UIImage(data: data)
        }
    }
    
}
