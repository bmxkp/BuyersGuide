//
//  ViewController.swift
//  BuyersGuide
//
//  Created by Kanjanaporn on 27/8/2562 BE.
//  Copyright © 2562 SCBiOS. All rights reserved.
//

import UIKit

class ListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var phones: [Phone] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ListController: UITableViewDataSource {
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

extension ListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

