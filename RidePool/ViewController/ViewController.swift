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




class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate{
    
    let locationManager = CLLocationManager()
    
   
    //model
    var user:Profile?
   
    
    var searchResults1:String?
    var searchResults2:String?
    
    //array contain the search data
    var searchSource :[String] = []
    
    
    @IBOutlet weak var mapView:MKMapView!
    @IBOutlet weak var navItem :UINavigationItem!
    @IBOutlet weak var searchButton : UIButton!
    @IBOutlet weak var searchFrom :UISearchBar!
    @IBOutlet weak var searchTo:UISearchBar!
    @IBOutlet weak var datePicker:UIDatePicker!
    @IBOutlet weak var search:UIButton!
    
    @IBOutlet weak var tableView1 :UITableView!
    @IBOutlet weak var tableView2 : UITableView!
    
    
    
    // create some lazy variable for the search completer
    
    lazy var searchCompleter : MKLocalSearchCompleter = {
        let sC = MKLocalSearchCompleter()
        sC.delegate = self
        return sC
    }()
    
    //lazy geocoder initialization
    lazy var geocoder = CLGeocoder()
    

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
    
    //MARK: Forward Geocoding function
    
    func geocoder(location : String){
        

        geocoder.geocodeAddressString(location){
            (placemarks, error) in
            self.processResponse(withPlacemarks : placemarks, error : error)
        }
        
        
    }
    
    func processResponse(withPlacemarks placemarks:[CLPlacemark]?, error:Error?){
        
        if let error = error{
            print("Unable to forward geocode address(\(error))")
        }else{
            var location :CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0{
                location = placemarks.first?.location
            }
            if let location = location{
                let coordinate = location.coordinate
            }else{
                print("no matching location found")
            }
        }
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
            if searchSource.count == 0{
                searchSource.append("Current Location")
            }

            return searchSource.count

        }

        else if tableView == tableView2{
                if searchSource.count == 0{
                       searchSource.append("Current Location")
                   }
            return searchSource.count

            }
        
        return searchSource.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if tableView == tableView1{
            let cell = tableView1.dequeueReusableCell(withIdentifier: "SearchFrom") as! UITableViewCell
            cell.textLabel?.text = searchSource[indexPath.row]

            return cell
        }

        else{
            let cell = tableView2.dequeueReusableCell(withIdentifier: "SearchTo") as! UITableViewCell
            cell.textLabel?.text = searchSource[indexPath.row]

            return cell
        }

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        if tableView == tableView1{
            if searchSource.count == 0{
                searchSource.append("Current Location")
            }
            searchFrom.text = searchSource[indexPath.row]
            searchResults1 = searchSource[indexPath.row]
            tableView1.isHidden = true
            searchSource.removeAll()
            searchFrom.endEditing(true)
            
        }
        
        if tableView == tableView2{
            if searchSource.count == 0{
                searchSource.append("Current Location")
            }
            searchTo.text = searchSource[indexPath.row]
            searchResults2 = searchSource[indexPath.row]
            tableView2.isHidden = true
            searchSource.removeAll()
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
            
            if !searchText.isEmpty{
            searchCompleter.queryFragment = searchText

            }

            tableView1.isHidden = false
            tableView1.reloadData()


        }

        if searchBar == searchTo{
            
            if !searchText.isEmpty{
                searchCompleter.queryFragment = searchText

            }

            tableView2.isHidden = false
            tableView2.reloadData()


        }
        
//        if searchBar == searchFrom{
//            if !searchText.isEmpty{
//                searchCompleter.queryFragment = searchText
//
//            }
//        }
        
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        if searchBar == searchFrom{
            searchFrom.text = ""
            searchSource.removeAll()
            tableView1.reloadData()
            tableView1.isHidden = true
    

        }
        
        if searchBar == searchTo{
            searchTo.text = ""
            searchSource.removeAll()
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



//MARK: Search Completer delegate
extension ViewController:MKLocalSearchCompleterDelegate{
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
         
            self.searchSource = completer.results.map {
                $0.title
                
                
            }
        DispatchQueue.main.async{
            self.tableView1.reloadData()
            self.tableView2.reloadData()
        }
        
            
        
        
    }
    
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // error handle
        
        print("MKCompleter error : \(error)")
    }
}
