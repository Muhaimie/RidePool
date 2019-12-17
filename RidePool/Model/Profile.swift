//
//  Profile.swift
//  RidePool
//
//  Created by Muhaimie Mazlah on 15/11/2019.
//  Copyright © 2019 Muhaimie Mazlah. All rights reserved.
//

import Foundation
import CoreLocation


struct Request {
    var from :String
    var to : String
    var requester : String
    var time : String
}


struct Ride {
    var from: String
    var to : String
    var giver : String
    var time : String
}

class Profile{
    
    var name:String
    var request:[Request] = []
    var ride : [Ride] = []
    
    init(name:String) {
        self.name = name
    }
    
    
}
