//
//  PickedBusStop.swift
//  MosGorTransBusStops
//
//  Created by Евгений Старшов on 23.02.2022.
//

import Foundation


final class PickedStop {
    static let shared = PickedStop()
    var busId = Datum(id: "", lat: 0.0, lon: 0, name: "", type: nil, routeNumber: "", color: "", routeName: "", subwayID: "", shareURL: "", wifi: false, usb: false, transportType: nil, transportTypes: [TypeElement](), isFavorite: true, icon: nil, mapIcon: nil, mapIconSmall: nil, cityShuttle: false, electrobus: false)
    private init() {}
}
