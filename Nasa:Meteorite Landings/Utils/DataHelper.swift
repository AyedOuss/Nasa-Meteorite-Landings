//
//  DataHelper.swift
//  Nasa:Meteorite Landings
//
//  Created by Oussama Ayed on 12/12/2017.
//  Copyright © 2017 Oussama Ayed. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON
import SwiftSpinner
class DataHelper {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    internal func seedMeteorites() {

        let urlString:NSString = "https://data.nasa.gov/resource/y77d-th95.json?$limit=100000"
        if let url = URL(string: urlString as String) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data)
                print(data)
                for result in json.arrayValue {
                    SwiftSpinner.show("Getting Data from NASA")
                    let year = result["year"].stringValue
                    if (year.count != 0){
                            let yearC = String(describing: year.prefix(4))
                            let y = Int(yearC)
                        if y as! Int > 2010 {
                            let meteorite = NSEntityDescription.insertNewObject(forEntityName: "Meteorite", into: context) as! Meteorite
                            meteorite.id = result["id"].int16Value as Int16
                            meteorite.name = result["name"].stringValue
                            meteorite.nametype = result["nametype"].stringValue
                            meteorite.mass = result["mass"].stringValue
                            meteorite.recclass = result["recclass"].stringValue
                            meteorite.reclat = result["reclat"].stringValue
                            meteorite.reclong = result["reclong"].stringValue
                            meteorite.fall = result["fall"].stringValue
                            meteorite.year = result["year"].stringValue
                            meteorite.latitude = result["geolocation"]["coordinates"][0].stringValue
                            meteorite.longitude = result["geolocation"]["coordinates"][1].stringValue
                        }
                    }
                }
                    }
                    do {
                        try context.save()
                    } catch _ {
                    }
                }
                else {
                    print("Server reported an error:")
            
        }
     SwiftSpinner.hide()
    }
    
}

    
    


