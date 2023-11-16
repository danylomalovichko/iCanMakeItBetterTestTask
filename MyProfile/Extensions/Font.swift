//
//  Font.swift
//  MyProfile
//
//  Created by Danylo Malovichko on 16.11.2023.
//

import SwiftUI

extension Font {
    
    struct SF {
        static func regularText(size: CGFloat) -> Font {
            .custom("SFProText-Regular", size: size)
        }
        
        static func semiboldDisplay(size: CGFloat) -> Font {
            .custom("SFProDisplay-Semibold", size: size)
        }
    }
}
