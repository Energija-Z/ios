//
//  AppDelegate.swift
//  TV Shows
//
//  Created by infinum on 12/07/2021.
//

import UIKit
import Alamofire

struct UserResponse: Decodable{
    let user: User
}

struct User: Decodable {
    let id: String
    let mail: String
    let imageUrl : String?

    enum CodingKeys: String, CodingKey  {
        case id
        case mail = "email"
        case imageUrl = "image_url"
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let _: [String: String] = [
            "email": "jaksa.ciglar@outlook.com",
            "password": "infinum1",
            "confirm_password": "infinum1"
        ]

        return true
    }
    
}
