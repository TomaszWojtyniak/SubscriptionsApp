//
//  String+Localized.swift
//  SharedUtilities
//
//  Created by Tomasz Wojtyniak on 12/07/2025.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle.main, comment: "")
    }
    
    func localized(_ bundle: Bundle = Bundle.main) -> String {
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
