//
//  ListDetailViewController.swift
//  BuyersGuide
//
//  Created by Kanjanaporn on 27/8/2562 BE.
//  Copyright © 2562 SCBiOS. All rights reserved.
//

import UIKit

class ListDetailController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var phoneDetail: Phone?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    
        
    }
    
    func setupUI(){
        title = phoneDetail?.name
        descriptLabel.text = phoneDetail?.description
        phoneImageView.kf.setImage(with: URL(string: phoneDetail!.thumbImageURL))
        // priceLabel.text = "Price: $\(phoneDetail.price)"
        //ratingLabel.text = "Rating: \(phoneDetail.rating)"
    }
    
}
