//
//  ViewController.swift
//  WeatherGift
//
//  Created by Morgan Prime on 10/12/20.
//  Copyright © 2020 Morgan Prime. All rights reserved.
//

import UIKit
import GooglePlaces

class LocationListViewController: UIViewController {
    
    
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var weatherLocations: [WeatherLocation] = []
    var selectedLocationIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var weatherLocation = WeatherLocation(name: "Chestnut Hill, MA", latitude: 0, longitude: 0)
//        weatherLocations.append(weatherLocation)
//        weatherLocation = WeatherLocation(name: "Boston, MA", latitude: 0, longitude: 0)
//        weatherLocations.append(weatherLocation)
//        weatherLocation = WeatherLocation(name: "Charlotte, NC", latitude: 0, longitude: 0)
//        weatherLocations.append(weatherLocation)
        
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func saveLocations(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(weatherLocations){
            UserDefaults.standard.set(encoded, forKey: "weatherLocations")
        }
        else{
            print("error save encoding didnt work")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        selectedLocationIndex = tableView.indexPathForSelectedRow!.row
        saveLocations()
    }
    
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        //Display the autocomplete view controller
        present(autocompleteController,animated: true, completion: nil)
    }
    
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing{
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBarButton.isEnabled = false
        }
        else{
            tableView.setEditing(false, animated: true)
            sender.title = "Done"
            addBarButton.isEnabled = false
        }
        
    }
    
}

extension LocationListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherLocations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = weatherLocations[indexPath.row].name
        cell.detailTextLabel?.text = "Lat: \(weatherLocations[indexPath.row].latitude) , Long: \(weatherLocations[indexPath.row].longitude)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            weatherLocations.remove(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = weatherLocations[sourceIndexPath.row]
        weatherLocations.remove(at: sourceIndexPath.row)
        weatherLocations.insert(itemToMove, at: destinationIndexPath.row)
    }
    
}

extension LocationListViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    
    let newLocation = WeatherLocation(name: place.name ?? "unknown place", latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
    weatherLocations.append(newLocation)
    tableView.reloadData()
    
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }


}
