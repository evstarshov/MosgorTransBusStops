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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickedStop = PickedStop.shared.busId
        let location = CLLocation(latitude: pickedStop.lat, longitude: pickedStop.lon)
        let regionRadius: CLLocationDistance = 500.0
        let position = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        barTitle.title = pickedStop.name
        mapView.delegate = self
        mapView.setRegion(position, animated: true)
        
    }
    
    @IBAction func backButtonTapped() {
        let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "tableVC") as! BusStopsTableViewController
        tableVC.modalPresentationStyle = .fullScreen
        self.present(tableVC, animated: true)
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("Start rendering")
    }
}
 
