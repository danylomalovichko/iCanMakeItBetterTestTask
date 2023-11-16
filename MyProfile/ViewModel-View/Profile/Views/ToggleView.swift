//
//  ToggleView.swift
//  MyProfile
//
//  Created by Danylo Malovichko on 16.11.2023.
//

import SwiftUI

struct ToggleView: View {
    
    let caption: String
    @Binding var value: Bool
    let action: () -> Void
    let color: Color
    
    var body: some View {
        VStack(spacing: 0) {
            Toggle(caption, isOn: $value)
                .font(Font.SF.regularText(size: 17))
                .toggleStyle(SwitchToggleStyle(tint: color))
                .allowsHitTesting(false)
                .overlay {
                    Button {
                        action()
                    } label: {
                        Color.clear
//                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 16)
        }
    }
}
