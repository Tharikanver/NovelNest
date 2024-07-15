//
//  NovelNesttApp.swift
//  NovelNestt
//
//  Created by MacMini on 12/04/1946 Saka.
//

import SwiftUI
import CoreData


@main
struct NovelNesttApp: App {
    
    let persistenceController = coreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            launchScreen()
                .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
        }
    }
}
