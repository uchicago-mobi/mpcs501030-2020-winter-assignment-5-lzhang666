//
//  DataManager.swift
//  where in the world
//
//  Created by Li Zhang on 2020-02-11.
//  Copyright © 2020 Li Zhang. All rights reserved.
//

import Foundation

public class DataManager{
    // make singleton
    public static let sharedInstance = DataManager()
    
    fileprivate init(){
        UserDefaults.standard.set([String](), forKey: "favPlaces")
    }
    
    struct placeInfo: Codable {
        var name: String
        var description: String
        var lat: Double
        var long: Double
        var type: Int
    }
    
    struct allData: Codable {
        var places: [placeInfo]
        var region: [Double]
    }
    
    var allPlaces = [String: placeInfo]()
    var startLat: Double?
    var startLong: Double?
    var startDimension1: Double?
    var startDimension2: Double?
    
    
    func loadAnnotitionFromPlist(){
        let path = Bundle.main.path(forResource: "Data", ofType: "plist")
        let xml = FileManager.default.contents(atPath: path!)
        let locations = try! PropertyListDecoder().decode(allData.self, from: xml!)
        for aPlace in locations.places {
            let key = aPlace.name
            allPlaces[key] = aPlace
        }
        startLat = locations.region[0]
        startLong = locations.region[1]
        startDimension1 = locations.region[2]
        startDimension2 = locations.region[3]
    }
    
    func saveFavorite(currentPlace: String){
        var favPlaces = UserDefaults.standard.object(forKey: "favPlaces") as! [String]
        favPlaces.append(currentPlace)
        print(favPlaces)
        UserDefaults.standard.set(favPlaces, forKey: "favPlaces")
    }
    
    func deleteFavorite(currentPlace: String){
        var favPlaces = UserDefaults.standard.object(forKey: "favPlaces") as! [String]
        if let index = favPlaces.firstIndex(of: currentPlace){
            favPlaces.remove(at: index)
            UserDefaults.standard.set(favPlaces, forKey: "favPlaces")
        }
        
    }
    
    func listFavorites(){
        
    }
    
}
