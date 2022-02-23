//
//  BusStopCellModel.swift
//  MosGorTransBusStops
//
//  Created by Евгений Старшов on 23.02.2022.
//

import Foundation


struct BusStopCellModel {
    let title: String
    let route: String?
    let icon: String?
}

final class BusStopCellModelFactory {
    
    static func cellModel(from model: Datum) -> BusStopCellModel {
        return BusStopCellModel(title: model.name,
                                route: model.routeName,
                                icon: model.mapIcon)
    }
}
