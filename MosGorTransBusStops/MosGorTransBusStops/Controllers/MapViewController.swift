//
//  ViewController.swift
//  MosGorTransBusStops
//
//  Created by Евгений Старшов on 23.02.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var barTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    
    @IBOutlet weak var timeArrivalLabel: UILabel!
    @IBOutlet weak var routeNumberLabel: UILabel!
    @IBOutlet weak var cityShuttleLabel: UILabel!
    @IBOutlet weak var electrobusLabel: UILabel!
    
    private let networkService = NetworkService()
    private var routePaths = [RoutePath]()
    private var routeNumbers: [String] = []
    private var timeArrival: [String] = []
    
 //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let long = PickedStop.shared.longiture
        let lat = PickedStop.shared.latitude
        let name = PickedStop.shared.stopName
        
        networkService.getPickedStopRoutePath { [weak self] routes in
            self?.routePaths = routes
            self?.configureRoutes()
        }
        
        
        mapView.delegate = self
        configureMap(long: long, lat: lat, name: name)
        
        
    }
    
//MARK: Back button
    
    @IBAction func backButtonTapped() {
        let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "tableVC") as! BusStopsTableViewController
        tableVC.modalPresentationStyle = .fullScreen
        self.present(tableVC, animated: true)
    }
    
//MARK: Map configuring
    
    private func configureMap(long: Double, lat: Double, name: String) {
        let location = CLLocation(latitude: lat, longitude: long)
        let regionRadius: CLLocationDistance = 500.0
        let position = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        barTitle.title = name
    mapView.setRegion(position, animated: true)
        
    }
    
//MARK: Routes configuring
    
    private func configureRoutes() {

        for i in routePaths {
            routeNumbers.append(i.number)
        }
        
        for i in routePaths {
            timeArrival.append(i.timeArrival.joined(separator: ", "))
        }
        
        
        routeNumberLabel.text = "Номера маршрутов: \(routeNumbers.joined(separator: ", "))"
        timeArrivalLabel.text = "Время прибытия: \(timeArrival.joined(separator: ", "))"
        
        for index in routePaths {
            if index.cityShuttle == true {
                cityShuttleLabel.text = "Городской шаттл ✅"
            } else {
                cityShuttleLabel.text = "Городской шаттл ❌"
            }
        }
        
        for index in routePaths {
            if index.electrobus == true {
                electrobusLabel.text = "Электробус ✅"
            } else {
                electrobusLabel.text = "Электробус ❌"
            }
        }
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("Start rendering")
    }
}
 
