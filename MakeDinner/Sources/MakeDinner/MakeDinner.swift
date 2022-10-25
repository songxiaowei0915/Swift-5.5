func chopVegetagle() async {
    print("Chopping vegetables")
}

func myCook() async {
    print("My own cooking approach.")
}

@main
public struct MakeDinner {
    public static func main() async {
        await chopVegetagle()
        
        print("Dinner is served")
        
        _ = await Dish()
        
        let dinner = Dinner()

        await dinner.cook {
            () async -> Void in
            await dinner.preheatOven()
        }
        
        await dinner.cook(myCook)
    }
}
