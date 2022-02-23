//
//  PickedBusStop.swift
//  MosGorTransBusStops
//
//  Created by Евгений Старшов on 23.02.2022.
//

import Foundation


final class PickedStop {
    static let shared = PickedStop()
    var busId: String = ""
    var latitude: Double = 0.0
    var longiture: Double = 0.0
    var stopName: String = ""
    private init() {}
}
