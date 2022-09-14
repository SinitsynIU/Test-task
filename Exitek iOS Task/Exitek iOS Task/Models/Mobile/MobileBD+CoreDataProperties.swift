//
//  MobileBD+CoreDataProperties.swift
//  Exitek iOS Task
//
//  Created by Илья Синицын on 02.09.2022.
//
//

import Foundation
import CoreData


extension MobileBD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MobileBD> {
        return NSFetchRequest<MobileBD>(entityName: "MobileBD")
    }

    @NSManaged public var imei: String?
    @NSManaged public var model: String?
}
