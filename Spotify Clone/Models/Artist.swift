//
//  Artist.swift
//  Spotify Clone
//
//  Created by HAMZA on 25/6/2022.
//

import Foundation


struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
    
}
