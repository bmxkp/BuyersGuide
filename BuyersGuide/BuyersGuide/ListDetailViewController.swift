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
    @IBOutlet var phoneImageView: UIImageView!
    @IBOutlet var descriptLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var sliderCollection: UICollectionView!
    //    @IBOutlet var pageControl: UIPageControl!

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

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.section
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }

    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.currentPage = 0
        pc.translatesAutoresizingMaskIntoConstraints = false

        return pc
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        sliderCollection.isPagingEnabled = true
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
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
        // priceLabel.text = "Price: $\(phoneDetail.price)"
        ratingLabel.text = "Rating: \(phoneDetail!.rating)"
        priceLabel.text = "Price: $\(phoneDetail!.price)"

        //        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let scrollPos = scrollView.contentOffset.x / view.frame.width
//        pageControl.currentPage = Int(scrollPos)
//    }
}
