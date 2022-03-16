//
//  CryptoCollectionViewCell.swift
//  CryptoCurrencyApp
//
//  Created by Mücahit Eren Özkur on 16.03.2022.
//

import UIKit

class CryptoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    func configure(with cryptoModel: CryptoModel) {
        //imageView.image = cryptoModel.iconURL
        changeLabel.textAlignment = .right
        symbolLabel.text = cryptoModel.symbol
        nameLabel.text = cryptoModel.name
        priceLabel.text = cryptoModel.price
        changeLabel.text = cryptoModel.change
        
        if let data = cryptoModel.imageData {
            imageView.image = UIImage(data: data)
        }
        else if let url = cryptoModel.iconURL {
            //fetch
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                //cryptoModel.imageData = data
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
        
        decideChangeColor(label: changeLabel)
        
    }
    
    public func decideChangeColor (label: UILabel) {
        guard let change = label.text?.hasPrefix("-") else {
            return
        }
        
        if change {
            changeLabel.textColor = .systemRed
        } else {
            changeLabel.textColor = .systemGreen
        }
    }
    
    
}
