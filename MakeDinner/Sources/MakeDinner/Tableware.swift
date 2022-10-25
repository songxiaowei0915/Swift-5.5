//
//  File.swift
//  
//
//  Created by 宋小伟 on 2022/10/25.
//

import Foundation

class Tableware {
    var color: String
    var shape: String
    
    init(color: String = "White", shape: String = "round") {
        self.color = color
        self.shape = shape
        
        print("Prepare tableware: Color:\(color), Shape:\(shape)")
    }
    
}

class Dish: Tableware {
    init() async {
        print("Disinfection the dish before use.")
    }
}


