//
//  Topper.swift
//  CoolSports
//
//  Created by Remya on 12/17/22.
//

import Foundation


struct Topper{
    var name:String
    var logo:String
    var value:Int
    var teamID:Int
    
    init(name:String,logo:String,value:Int = 0,teamID:Int){
        self.name = name
        self.logo = logo
        self.value = value
        self.teamID = teamID
    }
    
}
