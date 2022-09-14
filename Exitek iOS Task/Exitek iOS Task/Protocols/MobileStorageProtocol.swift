//
//  Protocol.swift
//  Exitek iOS Task
//
//  Created by Илья Синицын on 02.09.2022.
//

import Foundation

protocol MobileStorageProtocol {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}
