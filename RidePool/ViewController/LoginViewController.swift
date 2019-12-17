//
//  LoginViewController.swift
//  RidePool
//
//  Created by Muhaimie Mazlah on 16/11/2019.
//  Copyright © 2019 Muhaimie Mazlah. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //for checking the request
    var resultRequest = 0;
    
    //the user model
    var user = Profile(name: "")
    
    
    @IBOutlet weak var email:UITextField!
    @IBOutlet weak var password:UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toMain"{
            if resultRequest == 1{
                return true
            }else{
                return false
            }
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMain"{
            let vc = segue.destination as! UINavigationController
            let mvc = vc.viewControllers[0] as! ViewController
            mvc.user = self.user

        }
    }
    
    
    @IBAction func loginButtonClicked(_ sender:Any){
        
        //Please use own local ip address
        let url = NSURL(string: "http://192.168.64.2/login.php")
        
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        
        if  email.text == "" || password.text == ""{
          
            let alert = UIAlertController(title: "Error", message: "Please fill all the fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
           
            return
        }
        

        let emailD = "Email=\(email.text!)"
        let passwordD = "Password=\(password.text!)"
            
        //convert the post string to utf8
        
        let dataString = emailD + "&" + passwordD
        let dataD = dataString.data(using: .utf8)
        
        do{
            //get task
            let get = URLSession.shared.uploadTask(with: request, from: dataD){
                (data,response,error) in
                
                if error != nil{
                    DispatchQueue.main.async{
                        let alert = UIAlertController(nibName: "Fail to login.", bundle: nil)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }else{
                    
                    if let data = data{
                        
                        let returnData = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        
                        if returnData != "no"{
                            
                            DispatchQueue.main.async {
                               
                                self.user.name = returnData as! String
                                print(self.user.name)
                                self.performSegue(withIdentifier: "toMain", sender: self)
                            }
                            
                            
                        }else{
                            
                            DispatchQueue.main.async {
                                let alert = UIAlertController(title: "Login Error", message: "Please input correct email and password", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                self.resultRequest = 0
                            }
                        }
                    }
                    
                }
            }
            
            get.resume()
        }
        
        
        
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
