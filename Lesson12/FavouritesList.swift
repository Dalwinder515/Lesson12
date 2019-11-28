import Foundation
import UIKit

//singleton pattern

class FavouritesList
{
    private(set) var favourites:[String]
    
    //static let sharedFavouritesList=FavouritesList()
 
    class func getInstance()->FavouritesList
    {
        return instance
    }
    
    /*private static let var instance: FavouritesList {
        
    }*/
    
    private init(){
        let defaults=UserDefaults.standard
        let storedFavourites=defaults.object(forKey: "favourites") as? [String] //factory pattern
        favourites = storedFavourites != nil ? storedFavourites! : []
    }
    
    private static var instance: FavouritesList =
    {
        let favouriteList=FavouritesList()
        return favouriteList
    }()
    
    func addFavourites(fontName:String)->Void
    {
        if(!favourites.contains(fontName))
        {
            favourites.append(fontName)
            saveFavourites()
        }
    }
    
    func removeFavourites(fontName: String)->Void
    {
        if let index=favourites.index(of: fontName){
            favourites.remove(at: index)
            saveFavourites()
        }
    }
    
    private func saveFavourites()->Void{
        let defaults=UserDefaults.standard
        defaults.set(favourites, forKey: "favourites")
        defaults.synchronize()
    }
    
}

