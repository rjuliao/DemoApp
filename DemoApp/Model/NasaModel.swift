//
//  NasaModel.swift
//  DemoApp
//
//  Created by Raul Humberto Juliao Colina on 10/04/25.
//

struct NasaModel{
    let id: Int
    let roverName: String
    let earthDate: String
    let imgURL: String
    let fullName: String
    let landingDate: String
    let launchDate: String
    
    var roversNameS: String {
        return roverName.capitalized
    }
    var earthDateS: String {
        return earthDate.split(separator: "-").reversed().joined(separator: "/")
    }
    var fullNameS: String {
        return fullName.capitalized
    }
    var launchDateS: String {
        return launchDate.split(separator: "-").reversed().joined(separator: "/")
    }
    var landingDateS: String {
        return landingDate.split(separator: "-").reversed().joined(separator: "/")
    }
    var urlString: String {
        return imgURL
    }
    
}
