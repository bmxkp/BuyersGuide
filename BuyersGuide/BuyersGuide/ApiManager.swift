//
//  ApiManager.swift
//  BuyersGuide
//
//  Created by Kanjanaporn on 27/8/2562 BE.
//  Copyright © 2562 SCBiOS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol APIManagerProtocol {
    func getPhoneInfo(completion: @escaping (Swift.Result<[Phone], Error>) -> Void)
    func getImages(mobileId: Int,completion: @escaping (Swift.Result<[Images], Error>) -> Void)
}

class APIManager: APIManagerProtocol {
    static let shared: APIManager = APIManager()
    func getPhoneInfo(completion: @escaping (Swift.Result<[Phone], Error>) -> Void) {
        let baseURL: String = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
        AF.request(baseURL)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let json = try JSON(data: response.data!)
                        let phones: [Phone] = json.arrayValue.compactMap({ Phone(json: $0) })
                        completion(.success(phones))
                    } catch (let error) {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    func getImages(mobileId: Int,completion: @escaping (Swift.Result<[Images], Error>) -> Void){
        let baseURL: String = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(mobileId)/images/"
        AF.request(baseURL)
        .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let ImageSet = try JSONDecoder().decode([Images].self, from: response.data!)
                        completion(.success(ImageSet))
                    } catch (let error) {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
    }
    
}
}


