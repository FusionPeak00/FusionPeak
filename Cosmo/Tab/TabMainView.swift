//
//  TabMainView.swift
//
//  Created by D K on 04.12.2024.
//

import SwiftUI

struct TabMainView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var current = "Planner"
    @State private var isTabBarShown = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
               TabView(selection: $current) {
                   
                   MainView()
                       .tag("Planner")
                   
                   ClubService()
                       .tag("Moments")
                   
                   ClubsView()
                       .tag("Tips")
                   
                   SettingsView()
                       .tag("Settings")
                       .environmentObject(authViewModel)
                   
               }
               
               if isTabBarShown {
                   
                   HStack(spacing: 0) {
                       TabButton(title: "Planner", image: "homeIconFill", selected: $current)
                       
                       Spacer(minLength: 0)
                       
                       TabButton(title: "Moments", image: "gridIconFill", selected: $current)
                       
                       Spacer(minLength: 0)
                       
                       TabButton(title: "Tips", image: "clubsIconFill", selected: $current)
                       
                       Spacer(minLength: 0)
                       
                       TabButton(title: "Settings", image: "gearIconFill", selected: $current)
                       
                   }
                   .frame(width: size().width - 55, height: 80)
               }
           }
            .ignoresSafeArea()
        }
        .onAppear {
            if !UserDefaults.standard.bool(forKey: "init") {
                UserDefaults.standard.setValue(true, forKey: "init")
                UserDefaults.standard.setValue(generateUserCode(), forKey: "code")
            }
        }
    }
    
    func generateUserCode() -> String {
        var result = ""
        for _ in 0..<4 {
            let randomPart = String(format: "%02d", Int.random(in: 0...99))
            result += (result.isEmpty ? "" : " ") + randomPart
        }
        return result
    }
}


struct TabButton: View {
    var title: String
    var image: String
    
    @Binding var selected: String
    
    var body: some View {
        Button {
            withAnimation(.spring) {
                selected = title
            }
        } label: {
            HStack(spacing: 10) {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .shadow(color: selected == title ? .lightPurple : .black, radius: 10)
            }
            .foregroundColor(.white)
            .padding(.vertical, 7)
            .padding(.horizontal)
        }
    }
}

#Preview {
    TabMainView()
}
