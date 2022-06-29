//
//  SettingsModels.swift
//  Spotify Clone
//
//  Created by HAMZA on 28/6/2022.
//

import Foundation

struct section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
