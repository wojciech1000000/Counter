//
//  DataController.swift
//  Counter
//
//  Created by Wojciech Szczepanowski on 20/06/2024.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CigarettesModel")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}

