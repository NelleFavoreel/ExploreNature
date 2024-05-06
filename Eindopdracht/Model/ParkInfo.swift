//
//  ParkInfo.swift
//  Eindopdracht
//
//  Created by Nelle Favoreel on 04/04/2024.
//

import Foundation

struct ParkInfo: Codable, Identifiable {
    var id: String {
        return "\(business_product_id)-\(name)-\(city_name)"
    }
    let business_product_id: String
    let name: String
    let city_name: String
    let product_description: String
    let promotional_region: String
    let extra_facilities: String
    let phone1: String
    let email: String
    let website: String
    let lat: String
    let long: String
}
