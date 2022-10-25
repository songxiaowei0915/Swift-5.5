//
//  File.swift
//  
//
//  Created by 宋小伟 on 2022/10/25.
//

import Foundation

struct Dinner {
    func preheatOven(_ completionHandler: (() -> Void)? = nil)  {
        print("Preheat oven with completion handler.")
    }
    
    func preheatOven() async {
        print("Preheat over asynchronously.")
    }
    
    func cook(_ process: () async -> Void) async {
        await process()
    }
    
    
}
