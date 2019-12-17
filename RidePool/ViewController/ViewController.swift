//
//  ViewController.swift
//  RidePool
//
//  Created by Muhaimie Mazlah on 15/11/2019.
//  Copyright © 2019 Muhaimie Mazlah. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GooglePlaces
import GooglePlaces



class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate{
    
    let locationManager = CLLocationManager()
    
   
    //model
    var user:Profile?
   
    
    var searchResults1:[String] = []
    var searchResults2:[String] = []
    
    
    
    
    @IBOutlet weak var mapView:MKMapView!
    @IBOutlet weak var navItem :UINavigationItem!
    @IBOutlet weak var searchButton : UIButton!
    @IBOutlet weak var searchFrom :UISearchBar!
    @IBOutlet weak var searchTo:UISearchBar!
    @IBOutlet weak var datePicker:UIDatePicker!
    @IBOutlet weak var search:UIButton!
    
    @IBOutlet weak var tableView1 :UITableView!
    @IBOutlet weak var tableView2 : UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //data from login
        print(self.user?.name)
        
       
        
        //make the search components not visible
        search.isHidden = true
        searchFrom.isHidden = true
        searchTo.isHidden = true
        datePicker.isHidden = true
        tableView1.isHidden = true
        tableView2.isHidden = true
        search.isEnabled = false
        
        //core location
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toRide"{
        let VC = segue.destination as! RideViewController
        VC.user = self.user!
        }
        
        if segue.identifier == "toRequest"{
            let VC = segue.destination as! RequestViewController
            VC.user = self.user
        }
        
        
        return
        
    }
    
    
    
    
    
    //MARK: Autocomplete fucntion
    
    func placeAutocomplete(text_input:String)->[String]{
        
        var searchResult :[String] = []
        
        let filter = GMSAutocompleteFilter()
        let placesClient = GMSPlacesClient()
        filter.type = .address
              
        let bounds =  GMSCoordinateBounds(coordinate:mapView.userLocation.coordinate, coordinate: CLLocationCoordinate2D(latitude: 13.343668, longitude: 80.272055))
              
              placesClient.autocompleteQuery(text_input, bounds: bounds, filter: nil){
                  (results,error)-> Void in
                  
                self.searchResults2.removeAll()
                self.searchResults1.removeAll()
                  
                  if let error = error{
                      print("Autocomplete error \(error)")
                  }
                  
                  if let results = results{
                      
                      for result in results{
                        searchResult.append(result.attributedPrimaryText.string)
                      }
                  }
                  
                
                    
              }
        
            return searchResult
        }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locationValue, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationValue
        annotation.title = "You"
        mapView.addAnnotation(annotation)
        
    }
    
    
    //MARK: IB function
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        if searchFrom.isHidden == true{
            searchFrom.isHidden = false
            searchTo.isHidden = false
            search.isHidden = false
            datePicker.isHidden = false
            datePicker.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
            searchButton.setImage(UIImage(systemName: "pencil.slash"), for: .normal)
            
        }else{
                
            searchFrom.isHidden = true
            searchTo.isHidden = true
            search.isHidden = true
            datePicker.isHidden = true
            searchButton.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
            tableView1.isHidden = true
            tableView2.isHidden = true
        }
        
    }
    
    @IBAction func requestClicked(_ sender:Any){
        
        let fromLoc:String
        let toLoc : String
        let time : String
        
        let timeFormatter  = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        
        fromLoc = self.searchFrom.text!
        toLoc = self.searchTo.text!
        time = timeFormatter.string(from: datePicker.date)
        
        let request = Request(from: fromLoc, to: toLoc, requester: self.user!.name, time: time)
        
        
        
        self.user?.request.append(request)
        
        
        
        
        
        let alert = UIAlertController(title: "Done", message: "Your Request Have Been Sent.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style:.cancel, handler: nil))
        self.present(alert, animated: true, completion: {

            self.tableView1.isHidden = true
            self.tableView2.isHidden = true
            self.search.isHidden = true
            self.datePicker.isHidden = true
            self.searchFrom.isHidden = true
            self.searchTo.isHidden = true
            self.searchButton.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        })
        
    }
    
    //for unwind segue
    @IBAction func unWind(_ sender:UIStoryboardSegue){
        
    }
    
    
}




//MARK: TableView Data Source

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if tableView == tableView1{
            if searchResults1.count == 0{
                searchResults1.append("Current Location")
            }
            return searchResults1.count
            
        }
        
        else{
                if searchResults2.count == 0{
                       searchResults2.append("Current Location")
                   }
            return searchResults2.count
        
               }
        
        
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if tableView == tableView1{
            let cell = tableView1.dequeueReusableCell(withIdentifier: "SearchFrom") as! UITableViewCell
            cell.textLabel?.text = searchResults1[indexPath.row]

            return cell
        }

        else{
            let cell = tableView2.dequeueReusableCell(withIdentifier: "SearchTo") as! UITableViewCell
            cell.textLabel?.text = searchResults2[indexPath.row]

            return cell
        }

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if tableView == tableView1{
            if searchResults1.count == 0{
                searchResults1.append("Current Location")
            }
            searchFrom.text = searchResults1[indexPath.row]
                tableView1.isHidden = true
            
            searchFrom.endEditing(true)
            
        }
        
        if tableView == tableView2{
            if searchResults2.count == 0{
                searchResults2.append("Current Location")
            }
            searchTo.text = searchResults2[indexPath.row]
            tableView2.isHidden = true
            
            searchTo.endEditing(true)

        }
        
        if self.searchFrom.text != nil && self.searchTo.text != nil{
            self.search.isEnabled = true
        }
    }
    
}


//MARK: Search bar delegate


extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchBar == searchFrom{
            var text = searchBar.text
            placeAutocomplete(text_input: text!)
            tableView1.isHidden = false
            tableView1.reloadData()
            
            
        }
        
        if searchBar == searchTo{
            var text = searchBar.text
            placeAutocomplete(text_input: text!)
            tableView2.isHidden = false
            tableView2.reloadData()
            

        }
        
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar == searchFrom{
            searchFrom.text = ""
            tableView1.reloadData()
            tableView1.isHidden = true
        

        }
        
        if searchBar == searchTo{
            searchTo.text = ""
            tableView2.reloadData()
            tableView2.isHidden = true

        }
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar == searchFrom{
            self.tableView1.isHidden = true
            
        }
        
        if searchBar == searchTo {
            self.tableView2.isHidden = true
        }
    }
}

