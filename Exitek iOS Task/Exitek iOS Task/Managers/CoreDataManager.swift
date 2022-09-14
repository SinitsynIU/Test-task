//
//  CoreDataManager.swift
//  Exitek iOS Task
//
//  Created by Илья Синицын on 02.09.2022.
//
//

import CoreData

class CoreDataManager: MobileStorageProtocol {
    
    static let shared = CoreDataManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MobileBD")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = context
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createMobile(model: String?, imei: String?) -> MobileBD {
        let mobile = MobileBD(context: context)
        mobile.model = model ?? ""
        mobile.imei = imei ?? ""
        return mobile
    }
    
    func getAll() -> Set<Mobile> {
        let request = NSFetchRequest<MobileBD>(entityName: "MobileBD")
        guard let mobile = try? context.fetch(request) as? [Mobile] else { return [] }
        var setMobile: Set<Mobile> = []
            mobile.forEach { mobile in
                setMobile.insert(mobile)
            }
        return setMobile
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        let request = NSFetchRequest<MobileBD>(entityName: "MobileBD")
        request.predicate = NSPredicate(format: "imei = $@", imei)
        guard let mobile = try? context.fetch(request) as? [Mobile], !mobile.isEmpty else { return nil }
        return mobile.first
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        if exists(mobile) {
            throw MobileError.foundDuplicates
        } else {
            guard let mobiles = mobile as? MobileBD else { return }
            context.insert(mobiles)
            saveContext()
            return mobiles
        }
    }
    
    func delete(_ product: Mobile) throws {
        if exists(product) {
            guard let mobile = product as? MobileBD else { return }
            context.delete(mobile)
            saveContext()
        } else {
            throw MobileError.notDelete
        }
    }

    func exists(_ product: Mobile) -> Bool {
        let request = NSFetchRequest<MobileBD>(entityName: "MobileBD")
        guard let mobile = try? context.fetch(request) else { return false }
        for device in mobile {
            if device.imei == product.imei {
                print("Device-\(device.imei), Product-\(product.imei)")
                return true
            }
        }
        return false
    }
}
