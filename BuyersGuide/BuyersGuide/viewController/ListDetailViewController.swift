//
//  ListDetailViewController.swift
//  BuyersGuide
//
//  Created by Kanjanaporn on 27/8/2562 BE.
//  Copyright © 2562 SCBiOS. All rights reserved.
//

import Kingfisher
import UIKit

class ListDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var descriptLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var sliderCollection: UICollectionView!
    @IBOutlet var viewCell: UIView!


    var phoneDetail: Phone?
    var imageDetail: [Images] = []
    var mobileId: Int!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDetail.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        let image: Images = imageDetail[indexPath.row]
        cell.imageView.kf.setImage(with: URL(string: image.url))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.getImages(mobileId: mobileId){ [weak self] result in
            print("common,")
            switch result {
            case let .success(image):
                self?.imageDetail = image
                self?.sliderCollection.reloadData()
            case let .failure(error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(dismissAction)
                self?.present(alert, animated: true)
            }
        }
        setupUI()
    }

    
    func setupUI() {
        title = phoneDetail?.name
        descriptLabel.text = phoneDetail?.description
        ratingLabel.text = "Rating: \(phoneDetail!.rating)"
        priceLabel.text = "Price: $\(phoneDetail!.price)"
        sliderCollection.isPagingEnabled = true
        viewCell?.backgroundColor = UIColor(white: 1, alpha: 0.5)

    }

}
