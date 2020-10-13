//
//  PageViewController.swift
//  WeatherGift
//
//  Created by Morgan Prime on 10/13/20.
//  Copyright © 2020 Morgan Prime. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    var weatherLocations: [WeatherLocation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.delegate = self
        self.dataSource = self // saying code to handle this controller is all in here
        
        loadLocations()
        
        setViewControllers([createLocationDetailViewController(forPage: 0)], direction: .forward, animated: false, completion: nil)

    }
    
    func loadLocations(){
        guard let locationsEncoded = UserDefaults.standard.value(forKey: "weatherLocations") as? Data
            else {
                print("error couldnt load data, unless this is first time onpening then its fine")
                weatherLocations.append(WeatherLocation(name: "CURRENT LOCATION", latitude: 20.20, longitude: 20.20))
                return
        }
        let decoder = JSONDecoder()
        if let weatherLocations = try? decoder.decode(Array.self, from: locationsEncoded) as [WeatherLocation] {
            self.weatherLocations = weatherLocations
        }
        else{
            print("Couldnt decode data read from user defaults")
        }
        if weatherLocations.isEmpty {
            weatherLocations.append(WeatherLocation(name: "CURRENT LOCATION", latitude: 20.20, longitude: 20.20))
        }
    }
    
    func createLocationDetailViewController(forPage page: Int) -> LocationDetailViewController{
        let detailViewController = storyboard!.instantiateViewController(identifier: "LocationDetailViewController") as! LocationDetailViewController
        detailViewController.locationIndex = page
        return detailViewController
        
    }
    


}


extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? LocationDetailViewController{
            if currentViewController.locationIndex > 0 {
                return createLocationDetailViewController(forPage: currentViewController.locationIndex - 1)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentViewController = viewController as? LocationDetailViewController{
            if currentViewController.locationIndex < weatherLocations.count - 1 {
                return createLocationDetailViewController(forPage: currentViewController.locationIndex + 1)
            }
        }
        return nil
    }
    
    
}
