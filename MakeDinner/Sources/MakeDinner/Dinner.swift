//
//  File.swift
//  
//
//  Created by 宋小伟 on 2022/10/25.
//

import Foundation

struct Dinner {
//    func preheatOven(_ completionHandler: (() -> Void)? = nil)  {
//        print("Preheat oven with completion handler.")
//    }
//
//    func preheatOven() async {
//        print("Preheat over asynchronously.")
//    }
//
//    func cook(_ process: () async -> Void) async {
//        await process()
//    }
    enum Accident: Error {
        case knifeError
    }
    
    func chopVegetable() async -> Preparation {
        print("Chopping vegetables")
        return .ingredient(.vegetable)
    }
    
    func chopVegetable(name: String) async throws -> Preparation {
        if name == "rock" {
            throw Accident.knifeError
        }
        
        print("Chopping vegetables")
        return .ingredient(.vegetable)
    }
    
    func marinateMeat() async -> Preparation {
        print("Marinate meat")
        return .ingredient(.meat)
    }
    
    func chop(names: [String]) async throws -> [Food] {
        var veggies: [Food] = []
        
        if #available(iOS 13.0, *) {
            try await withThrowingTaskGroup(of: Preparation.self){ group in
                for name in names {
                    group.addTask {
                        try await chopVegetable(name: name)
                    }
                }
                
                while let prep = try await group.next(), case .ingredient(let veggie) = prep {
                    if veggies.count >= 3 {
                        group.cancelAll()
                        break
                    }
                    else {
                        veggies.append(veggie)
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
        return veggies
    }
}

enum Food {
    case vegetable
    case meat
}

struct Meal {
    func eat() {
        print("Yum!")
    }
}

struct Oven {
    func preheatOven() async -> Preparation {
        print("Preheat over.")
        
        return .device
    }
    
    func cook(_ foods: [Food], seconds: Int) -> Meal {
        print("Cook \(seconds) seconds")
        return Meal()
    }
}

enum Preparation {
    case ingredient(Food)
    case device
}
