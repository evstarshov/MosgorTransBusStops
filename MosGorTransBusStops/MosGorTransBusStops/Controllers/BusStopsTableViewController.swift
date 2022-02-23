//
//  BusStopsTableViewController.swift
//  MosGorTransBusStops
//
//  Created by Евгений Старшов on 23.02.2022.
//

import UIKit

class BusStopsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let networkService = NetworkService()
    
    private var busStops = [Datum]()
    private var searchResults = [Datum]()

    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.getBusStops { [weak self] stops in
            self?.searchResults = stops.sorted { $0.name < $1.name }
            self?.tableView.reloadData()
        }
        
        searchBar.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "stopsCell")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopsCell", for: indexPath)
        
        let busStop = self.searchResults[indexPath.row]
        let cellModel = BusStopCellModelFactory.cellModel(from: busStop)
        cell.textLabel?.text = cellModel.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PickedStop.shared.busId = searchResults[indexPath.row].id
        PickedStop.shared.latitude = searchResults[indexPath.row].lat
        PickedStop.shared.longiture = searchResults[indexPath.row].lon
        PickedStop.shared.stopName = searchResults[indexPath.row].name
        tableView.deselectRow(at: indexPath, animated: true)
        print("Opening mapview")
        let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapViewController
        mapVC.modalPresentationStyle = .fullScreen
        self.present(mapVC, animated: true)
    }
    
    private func requestBusStop(with query: String) {
        
        self.searchResults = busStops.filter { $0.name == query.lowercased() }
        if self.searchResults.isEmpty {
            showAlert(message: "Остановка не найдена")
        }
        self.tableView.isHidden = false
        self.tableView.reloadData()
        self.searchBar.resignFirstResponder()
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


//MARK: - UISearchBarDelegate

extension BusStopsTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        self.requestBusStop(with: query)
    }
}
