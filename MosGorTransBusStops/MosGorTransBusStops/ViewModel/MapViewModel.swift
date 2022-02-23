//
//  MapViewModel.swift
//  MosGorTransBusStops
//
//  Created by Евгений Старшов on 23.02.2022.
//

import UIKit

final class MapViewModel {
    let service: NetworkService
    var busStop: [Datum] = []
    
    init(service: NetworkService) {
        self.service = service
    }
    
    public func fetch() {
        service.getBusStops { [weak self] stop in
            
            self?.busStop = stop
            
        }
    }
}
