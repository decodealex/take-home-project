//
//  PackageModel.swift
//  FightCamp-Homework
//
//  Created by Oleksandr Kovalyshyn on 29.07.2020.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

struct Package: Codable {
    let title: String
    let desc: String
    let payment: String
    let price: Int
    let action: String
    let headline: String?
    let thumbnailUrls: [String]
    let included: [String]
    let excluded: [String]?
}
