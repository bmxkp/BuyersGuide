//
//  PhoneTableViewCell.swift
//  BuyersGuide
//
//  Created by Kanjanaporn on 27/8/2562 BE.
//  Copyright © 2562 SCBiOS. All rights reserved.
//

import UIKit
import Kingfisher

class PhoneTableViewCell: UITableViewCell {
    static let CellIdentifier: String = "PhoneTableViewCell"
    
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(phone: Phone) {
     
        nameLabel.text = phone.name
        descriptLabel.text = phone.description
        priceLabel.text = "Price: $\(phone.price)"
        ratingLabel.text = "Rating: \(phone.rating)"
        let url = phone.thumbImageURL
        if url.contains("http") {
            phoneImageView.kf.setImage(with: URL(string: url))
        }
        else {
            phoneImageView.kf.setImage(with: URL(string: "http://\(url)"))
        }

    }
    
        override func prepareForReuse() {
            super.prepareForReuse()
            phoneImageView.image = nil
        }
}

