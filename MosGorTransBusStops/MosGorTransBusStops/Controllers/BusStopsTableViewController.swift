//
//  BusStopsTableViewController.swift
//  MosGorTransBusStops
//
//  Created by Евгений Старшов on 23.02.2022.
//

import UIKit

class BusStopsTableViewController: UITableViewController {
    
    let networkService = NetworkService()
    
    var busStops = [Datum]()

    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.getBusStops { [weak self] stops in
            self?.busStops = stops
            self?.tableView.reloadData()
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "stopsCell")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return busStops.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busStops.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopsCell", for: indexPath)

        cell.textLabel?.text = busStops[indexPath.row].name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PickedStop.shared.busId = busStops[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        print("Opening mapview")
        let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapViewController
        mapVC.modalPresentationStyle = .fullScreen
        self.present(mapVC, animated: true)
    }
}
