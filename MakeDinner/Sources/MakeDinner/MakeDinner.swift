func chopVegetagle() async {
    print("Chopping vegetables")
}

func myCook() async {
    print("My own cooking approach.")
}

//func makeDinner() async -> Meal {
//    let dinner = Dinner()
//    let veggies = await dinner.chopVegetable()
//    let meat = await dinner.marinateMeat()
//    
//    let oven = Oven()
//    await oven.preheatOven()
//    let meal = Oven().cook([veggies,meat], seconds: 300)
//    
//    return meal
//}

@available(iOS 13.0, *)
func makeDinnerWithTaskGroup() async -> Meal {
    var foods: [Food] = []
    let oven = Oven()

     await withTaskGroup(of: Preparation.self, body: {
        group in
        let dinner = Dinner()

        group.addTask {
            await dinner.chopVegetable()
        }

        group.addTask {
            await dinner.marinateMeat()
        }

        group.addTask {
            await oven.preheatOven()
        }

        while let prep = await group.next(), case Preparation.ingredient(let food) = prep {
            foods.append(food)
        }
    })

    return oven.cook(foods, seconds: 300)
}

@available(iOS 13.0, *)
func makeDinnerWithThrowingTaskGroup() async throws -> Meal {
    var foods: [Food] = []
    let oven = Oven()
    
     try await withThrowingTaskGroup(of: Preparation.self, body: {
        group in
        let dinner = Dinner()
        
        group.addTask {
            try await dinner.chopVegetable(name: "rock")
        }
        
        group.addTask {
            guard !Task.isCancelled else {
                throw CancellationError()
            }
            return await dinner.marinateMeat()
        }
        
        group.addTask {
            await oven.preheatOven()
        }
        
        while let prep = try await group.next(), case Preparation.ingredient(let food) = prep {
            foods.append(food)
        }
    })
    
    return oven.cook(foods, seconds: 300)
}

@available(iOS 13.0, *)
func eat(_ task: Task<Meal,Error>) async throws {
    let meal = try await task.value
    meal.eat()
}

@main
public struct MakeDinner {
    public static func main() async {
//        await chopVegetagle()
//
//        print("Dinner is served")
//
//        _ = await Dish()
        
        
        

//        await dinner.cook {
//            () async -> Void in
//            await dinner.preheatOven()
//        }
//
//        await dinner.cook(myCook)
        
//        Fornum().update(userIds: Array(0 ..< 100))
//        Fornum().update(userIds: Array(0 ..< 100))
//        Fornum().update(userIds: Array(0 ..< 100))
//        Fornum().update(userIds: Array(0 ..< 100))
//        Fornum().update(userIds: Array(0 ..< 100))
        
//        let forum = Fornum()
//        await forum.updateAsync(userIds: forum.fetchUserIds())
        
        //_ = await makeDinner()
        
        if #available(iOS 13.0, *) {
            _ = await makeDinnerWithTaskGroup()
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 13.0, *) {
            do {
                _ = try await makeDinnerWithThrowingTaskGroup()
            }catch {
                print(error.localizedDescription)
            }
            
            do {
                let veggies = try await Dinner().chop(names: ["tomato", "cucumber", "celery", "cabbage"])
            }catch {
                print(error.localizedDescription)
            }
            
            ///---------------------
            let meal = Task(priority: .userInitiated) { () -> Meal in
                try await makeDinnerWithTaskGroup()
            }
            try? await eat(meal)
            
            ///----------------------
            
            //Task(priority: .userInitiated) {
                Task.detached {
                    print("Start playing BGM.")
                }
                
                let meal2 = Task(priority: .userInitiated) { () -> Meal in
                    try await makeDinnerWithThrowingTaskGroup()
                }
                try? await eat(meal2)
                
                Task.detached {
                    print("Stop playing BGM.")
                }
            //}
        }
        
        
    }
}
