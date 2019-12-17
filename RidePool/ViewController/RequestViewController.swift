//
//  RideViewViewController.swift
//  RidePool
//
//  Created by Muhaimie Mazlah on 15/11/2019.
//  Copyright © 2019 Muhaimie Mazlah. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController {

    var user:Profile?
    
    
    @IBOutlet weak var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Request"
        // Do any additional setup after loading the view.
        print(user?.name)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RequestViewController:UITableViewDataSource,UITableViewDelegate{
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.request.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell") as! RequestTableViewCell
        cell.from.text = self.user?.request[indexPath.row].from
        cell.to.text = self.user?.request[indexPath.row].to
        cell.time.text = self.user?.request[indexPath.row].time
        cell.requester.text = self.user?.request[indexPath.row].requester
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ride = Ride(from: (user?.request[indexPath.row].from)!, to: (user?.request[indexPath.row].to)!, giver: user!.name, time: (user?.request[indexPath.row].time)!)
        
        let alert = UIAlertController(title: "Accept Request", message: "Are you sure to accept this request?", preferredStyle: .alert)
        
        let cancelAction  = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: {
            (_) -> Void in
            self.user?.ride.append(ride)
            
            self.user?.request.remove(at: indexPath.row)
            tableView.reloadData()
            
        })
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
        tableView.cellForRow(at: indexPath)?.isSelected  = false
    }
    
}
