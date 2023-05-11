//
//  Vendor.swift
//  middleTestTask
//
//  Created by Dmytro Vakulinsky on 10.05.2023.
//

import Foundation

struct Vendor: Codable, Identifiable {
    let id: Int
    let company_name: String
    let area_served: String
    let shop_type: String
    let favorited: Bool
    let follow: Bool
    let business_type: String
    let cover_photo: CoverPhoto
    let categories: [Category]
    let tags: [Tag]
}

struct CoverPhoto: Codable {
    let id: Int
    let media_url: URL?
    let media_type: String
}

struct Category: Codable {
    let id: Int
    let name: String
    let image: MockedImage
}

struct MockedImage: Codable {
    let id: Int
    let media_url: String
    let media_type: String
}

struct Tag: Codable {
    let id: Int
    let name: String
    let purpose: String
}

