//
//  MobileError.swift
//  Exitek iOS Task
//
//  Created by Илья Синицын on 02.09.2022.
//
//

import Foundation

enum MobileError {
    case foundDuplicates
    case notDelete
}

extension MobileError: LocalizedError {
    var errorDescription: String?  {
        switch self {
        case .foundDuplicates:
            return NSLocalizedString("Error, this mobile is available in no data!", comment: "")
        case .notDelete:
            return NSLocalizedString("Error, product is not delete!", comment: "")
        }
    }
}
