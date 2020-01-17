//
//  Notizen+CoreDataProperties.swift
//  Notizbuch
//
//  Created by Magnus Kruschwitz on 14.01.20.
//  Copyright © 2020 Magnus Kruschwitz. All rights reserved.
//
//

import Foundation
import CoreData


extension Notizen {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notizen> {
        return NSFetchRequest<Notizen>(entityName: "Notizen")
    }

    @NSManaged public var headline: String?
    @NSManaged public var content: String?

}
