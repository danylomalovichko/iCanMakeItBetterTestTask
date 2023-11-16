//
//  ProfileView.swift
//  MyProfile
//
//  Created by Danylo Malovichko on 16.11.2023.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @Environment(\.openURL) var openURL
    @StateObject var vm: ProfileVM
    
    @State var selectedItem: PhotosPickerItem?
    
    var body: some View {
        
        VStack(spacing: 24) {
            
            header()
            
            avatar()
            
            messagesSwitch()
            
            fields()
            
            info()
            
            Spacer()
            
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.regularPurple, Color.darkerPurple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(0.4)
                .ignoresSafeArea()
        }
        .background {
            Color.backgroundColor.ignoresSafeArea()
        }
        .onReceive(NotificationCenter.default.publisher(
            for: UIApplication.willEnterForegroundNotification
        )) { _ in
            vm.reloadAuthorizedStatus()
            print("willEnterForegroundNotification")
        }
        
    }
}

// MARK: Views
private extension ProfileView {
    
    @ViewBuilder private func header() -> some View {
        HStack {
            
            Text("My profile")
                .font(Font.SF.semiboldDisplay(size: 20))
                .foregroundColor(.white)
            
            Spacer()
            
            ShareLink(item: vm.shareUrl) {
                Image("ShareIcon")
                    .tint(.white)
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder private func avatar() -> some View {
        PhotosPicker(selection: $selectedItem) {
            Circle()
                .fill(.gray)
                .frame(width: 80, height: 80)
                .overlay {
                    Image(uiImage: vm.user.image ?? .init())
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                }
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                guard let imageData = try? await newItem?.loadTransferable(type: Data.self) else {
                    return
                }
                guard let selectedPhoto = UIImage(data: imageData) else {
                    return
                }
                vm.updateUserImage(selectedPhoto)
            }
        }
    }
        
    @ViewBuilder private func messagesSwitch() -> some View {
        ToggleView(caption: "Push notifications", value: $vm.isNotificationsAuthorized, action: {
            openSettings()
        }, color: .green)
        .frame(height: 44)
        .foregroundColor(.white)
        .background {
            Color(hex: "EBEBF5")
                .opacity(0.18)
                .cornerRadius(14)
        }
        .padding(.horizontal, 16)
    }
    
    
    @ViewBuilder private func fields() -> some View {
        VStack {
            HStack {
                TextField("", text: $vm.user.name, prompt: Text("Name")
                    .foregroundColor(.gray))
                    .foregroundColor(.white)
                    .font(Font.SF.regularText(size: 17))
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 8, height: 14)
                    .foregroundColor(Color(hex: "#F2F2F7"))
            }
                
            Divider()
                .overlay(Color.greySeparatorColor)
                .frame(height: 1)

            HStack {
                TextField("", text: $vm.user.surname, prompt: Text("Surname")
                    .foregroundColor(.gray))
                    .foregroundColor(.white)
                    .font(Font.SF.regularText(size: 17))

                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 8, height: 14)
                    .foregroundColor(Color(hex: "#F2F2F7"))
            }
            
            Divider()
                .overlay(Color.greySeparatorColor)
                .frame(height: 1)

            HStack {
                TextField("", text: $vm.user.username, prompt: Text("Username")
                    .foregroundColor(.gray))
                    .foregroundColor(.white)
                    .font(Font.SF.regularText(size: 17))

                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 8, height: 14)
                    .foregroundColor(Color(hex: "#F2F2F7"))
            }
            
            Divider()
                .overlay(Color.greySeparatorColor)
                .frame(height: 1)

        }
        .padding(16)
        .background {
            Color(hex: "EBEBF5")
                .opacity(0.18)
                .cornerRadius(14)
        }
        .padding(.horizontal, 16)
    }
}

@ViewBuilder private func info() -> some View {
    VStack {
        HStack {
            Link("Share app", destination: URL(string: "http://imakebetter.com")!)
                .foregroundColor(.white)
                .font(Font.SF.regularText(size: 17))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 8, height: 14)
                .foregroundColor(Color(hex: "#F2F2F7"))
        }
            
        Divider()
            .overlay(Color.greySeparatorColor)
            .frame(height: 1)

        HStack {
            Link("Privacy policy", destination: URL(string: "http://imakebetter.com")!)
                .foregroundColor(.white)
                .font(Font.SF.regularText(size: 17))
            
            Spacer()

            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 8, height: 14)
                .foregroundColor(Color(hex: "#F2F2F7"))
        }
        
        Divider()
            .overlay(Color.greySeparatorColor)
            .frame(height: 1)

        HStack {
            Link("Contact us", destination: URL(string: "http://imakebetter.com")!)
                .foregroundColor(.white)
                .font(Font.SF.regularText(size: 17))

            Spacer()

            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 8, height: 14)
                .foregroundColor(Color(hex: "#F2F2F7"))
        }
        
        Divider()
            .overlay(Color.greySeparatorColor)
            .frame(height: 1)

    }
    .padding(16)
    .background {
        Color(hex: "EBEBF5")
            .opacity(0.18)
            .cornerRadius(14)
    }
    .padding(.horizontal, 16)
}

// MARK: functions
private extension ProfileView {
    private func openSettings() {
        guard let openSettingsURL = URL(string: UIApplication.openSettingsURLString) else {
            assertionFailure()
            return
        }
        openURL(openSettingsURL)
    }
}
