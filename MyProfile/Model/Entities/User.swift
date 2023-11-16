//
//  User.swift
//  MyProfile
//
//  Created by Danylo Malovichko on 15.11.2023.
//

import Foundation
import UIKit.UIImage

struct User:  Hashable, Equatable, Sendable  {
    var name: String
    var surname: String
    var username: String
    var image: UIImage?
}
