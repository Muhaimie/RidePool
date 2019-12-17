//
//  ProfileViewController.swift
//  RidePool
//
//  Created by Muhaimie Mazlah on 15/11/2019.
//  Copyright © 2019 Muhaimie Mazlah. All rights reserved.
//

import UIKit

class RideViewController: UIViewController,UITableViewDelegate{
    
    var user:Profile?
    
    
    @IBOutlet weak var tableView:UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight  = 175
       
        
        // Do any additional setup after loading the view.
        
        self.title = "\(user!.name)'s ride"
        //print(user!.ride.count)
    }
    
    
   

}

extension RideViewController:UITableViewDataSource{
    
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return user?.ride.count ?? 0
        
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RideCell", for: indexPath) as! RideTableViewCell
        
        
        
        let ride = user!.ride[indexPath.row]

        cell.driver.text = ride.giver
        cell.fromValue.text = ride.from
        cell.toValue.text = ride.to
        cell.timeValue.text = ride.time

        
        return cell
    }
            
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            user?.ride.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
}



