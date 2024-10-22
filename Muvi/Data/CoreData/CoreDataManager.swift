//
//  CoreDataManager.swift
//  Muvi
//
//  Created by Ivan Nur Ilham Syah on 22/10/24.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
  static let shared = CoreDataManager()
  
  private init() {}
  
  lazy var container: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "MovieDataModel")
    
    container.loadPersistentStores { _, err in
      if let err {
        fatalError("Failed to load persistent stores: \(err.localizedDescription)")
      }
    }
    
    return container
  }()
}
