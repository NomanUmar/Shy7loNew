//
//  UrlExtention.swift
//  Shy7lo
//
//  Created by Sajjad Yousaf on 8/8/18.
//  Copyright © 2018 Sajjad Yousaf. All rights reserved.
//

import Foundation
extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
