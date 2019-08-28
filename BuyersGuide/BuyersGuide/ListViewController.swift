//
//  ViewController.swift
//  BuyersGuide
//
//  Created by Kanjanaporn on 27/8/2562 BE.
//  Copyright © 2562 SCBiOS. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var phones: [Phone] = []{
        didSet {
            tableView.reloadData()

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        APIManager.shared.getPhoneInfo { [weak self] result in
            switch result {
            case .success(let phones):
                self?.phones = phones
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(dismissAction)
                self?.present(alert, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "listDetail" {
            let viewController = segue.destination as? ListDetailController
            let indexPath = tableView.indexPathForSelectedRow
            if let indexPath = indexPath {
                viewController?.phoneDetail = phones[(indexPath as NSIndexPath).row]

            }
        }
    }
    
    func showNormalAlert(message:String){
        let alertVC = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func actionSort(_ sender: Any) {
        let alert = UIAlertController(title: "AlertController Tutorial",
                                      message: "Sorting",
                                      preferredStyle: .alert)
        let sortLowtoHight = UIAlertAction(title: "Sort Low to Hight", style: .default,handler: { (action) -> Void in
            self.phones = self.phones.sorted(by: { $0.price < $1.price })
            self.tableView.reloadData()
        })
        let sortHighttoLow = UIAlertAction(title: "Sort Hight to Low", style: .default,handler: { (action) -> Void in
            self.phones = self.phones.sorted(by: { $0.price > $1.price })
            self.tableView.reloadData()
        })
        let sortRating = UIAlertAction(title: "Rating", style: .default,handler: { (action) -> Void in
            self.phones = self.phones.sorted(by: { $0.rating > $1.rating })
            self.tableView.reloadData()
        })
       
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        alert.addAction(sortLowtoHight)
        alert.addAction(sortHighttoLow)
        alert.addAction(sortRating)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhoneTableViewCell.CellIdentifier, for: indexPath) as? PhoneTableViewCell else {
            return UITableViewCell()
        }
        let phone: Phone = phones[indexPath.item]
        cell.configCell(phone: phone)
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

