//
//  domainData.swift
//  DietDiary
//
//  Created by Alicia Chiu on 2021/4/6.
//

import Foundation
import ObjectMapper

class DomainData: Mappable {
    
    var domain: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        domain <- map["domain"]
    }
}

