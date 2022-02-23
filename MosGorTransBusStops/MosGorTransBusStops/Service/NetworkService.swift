//
//  NetworkService.swift
//  MosGorTransBusStops
//
//  Created by Евгений Старшов on 23.02.2022.
//

import Foundation
import Alamofire

final class NetworkService {
    
    private let url = "https://api.mosgorpass.ru/v8.2/stop"
    
    func getBusStops(complition: @escaping([Datum])->()) {
        print("Getting bus stops")
        AF.request(url, method: .get).responseJSON { response in
            guard let data = response.data else { return }
            //print(String(decoding: response.data!, as: UTF8.self))
            DispatchQueue.main.async {
                do {
                    let json = try JSONDecoder().decode(Welcome.self, from: data).data
                    let busStops: [Datum] = json
                    complition(busStops)
                } catch {
                    print(error)
                }
            }
        }
    }
    
}
