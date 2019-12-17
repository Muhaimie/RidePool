//
//  RegisterViewController.swift
//  
//
//  Created by Muhaimie Mazlah on 16/11/2019.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var name:UITextField!
    @IBOutlet weak var email:UITextField!
    @IBOutlet weak var password:UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signUpButtonClicked(_ sender:Any){
        
        //Please use own local ip address intead.
        let url = NSURL(string: "http://192.168.64.2/post_data.php")
        
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        
        if name.text == "" || email.text == "" || password.text == ""{
          
            let alert = UIAlertController(title: "Error", message: "Please fill all the fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
           
            return
        }
            
        let nameD = "Name=\(name.text!)"
        let emailD = "Email=\(email.text!)"
        let passwordD = "Password=\(password.text!)"
            
        //convert the post string to utf8
        
        let dataString = nameD + "&" + emailD + "&" + passwordD
        let dataD = dataString.data(using: .utf8)
        
        do{
            
            //upload task
            let upload = URLSession.shared.uploadTask(with: request, from: dataD){
                
                data,response,error in
                
                if error != nil{
                    
                    DispatchQueue.main.async {
                        
                        let alert = UIAlertController(title: "Register Error", message: "Please try again later.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                }else{
                    if let data = data{
                        let returnData = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                        
                        //database insertion worked
                        if returnData == "1"{
                            DispatchQueue.main.async {
                                    
                                let alert = UIAlertController(title: "Register Complete", message: "Please login in the login page. ", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
                                    (action) -> Void in
                                    
                                    let viewController = self.storyboard?.instantiateViewController(identifier: "LoginViewController")
                                    
                                    self.present(viewController!, animated: true, completion: nil)

                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                            
                            
                        }else{
                            
                            DispatchQueue.main.async {
                                let alert = UIAlertController(title: "Register Error", message: "Something gone wrong when registering.Please try again later.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                            
                        }
                        
                        
                    }
                
            }
                
            }
            upload.resume()
            
        }
        
        
    }
    
    @IBAction func cancelButtonClicked(_ sender:Any){
        self.dismiss(animated: true, completion: nil)
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
