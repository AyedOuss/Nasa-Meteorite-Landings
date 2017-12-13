//
//  Meteorite+CoreDataProperties.swift
//  Nasa:Meteorite Landings
//
//  Created by Oussama Ayed on 12/12/2017.
//  Copyright © 2017 Oussama Ayed. All rights reserved.
//
//

import Foundation
import CoreData


extension Meteorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meteorite> {
        return NSFetchRequest<Meteorite>(entityName: "Meteorite")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var nametype: String?
    @NSManaged public var mass: String?
    @NSManaged public var recclass: String?
    @NSManaged public var reclat: String?
    @NSManaged public var reclong: String?
    @NSManaged public var year: String?
    @NSManaged public var longitude: String?
    @NSManaged public var latitude: String?
    @NSManaged public var fall: String?

}
