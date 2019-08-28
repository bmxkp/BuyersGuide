//
//  ListDetailViewController.swift
//  BuyersGuide
//
//  Created by Kanjanaporn on 27/8/2562 BE.
//  Copyright © 2562 SCBiOS. All rights reserved.
//

import UIKit
import Kingfisher

class ListDetailController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var sliderCollection: UICollectionView!
    
    
    var phoneDetail: Phone?
    var imageDetail: [Images] = []


    override func viewDidLoad() {
        super.viewDidLoad()
       // sliderCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ID")
        sliderCollection.isPagingEnabled = true
        APIManager.shared.getImages { [weak self] result in
            print("common,")
            switch result {
            case .success(let image):
                self?.imageDetail = image
                self?.loadView()
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(dismissAction)
                self?.present(alert, animated: true)
            }
        setupUI()
    
        
    }
    
    func setupUI(){
        title = phoneDetail?.name
        descriptLabel.text = phoneDetail?.description
        // priceLabel.text = "Price: $\(phoneDetail.price)"
        //ratingLabel.text = "Rating: \(phoneDetail.rating)"
        
    }
        
     
    

}
