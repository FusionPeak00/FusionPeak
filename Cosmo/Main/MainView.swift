//
//  MainView.swift
//
//  Created by D K on 02.12.2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var isUserShown = false
    @State private var isReservShown = false
    @State private var isFootballShown = false
    @State private var isPCShown = false
    @State private var isConsoleShown = false
    @State private var isCampShown = false
    
    @State private var name = "USER"
    @State private var image = "cosmo4"
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
            
            VStack {
                Text("FUSION PEAK")
                    .foregroundColor(.white)
                    .font(.system(size: 28, weight: .black))
                    .frame(width: size().width - 40, alignment: .leading)
                
                Rectangle()
                    .foregroundColor(.semiPurple)
                    .frame(width: size().width - 40, height: 160)
                    .cornerRadius(24)
                    .overlay {
                        HStack {
                            VStack {
                                Text(name)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20, weight: .black))
                                
                                Image(image)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                
                                Button {
                                    isUserShown.toggle()
                                } label: {
                                    Text("Edit")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .semibold))
                                }
                                .padding(6)
                                .padding(.horizontal, 30)
                                .background {
                                    RoundedRectangle(cornerRadius: 24)
                                        .foregroundColor(.lightPurple)
                                }
                            }
                            
                            Spacer()
                            
                            Circle()
                                .stroke(lineWidth: 10)
                                .fill(LinearGradient(colors: [.lightPurple, .purple], startPoint: .top, endPoint: .bottom))
                                .frame(width: 100, height: 100)
                                .overlay {
                                    VStack {
                                        Text("1")
                                            .font(.system(size: 38, weight: .black))
                                        Text("lvl")
                                            .font(.system(size: 24, weight: .light))
                                    }
                                    .foregroundColor(.white)
                                }
                        }
                        .padding(.horizontal, 35)
                    }
                
                Text("ROOMS")
                    .foregroundColor(.white)
                    .font(.system(size: 22, weight: .black))
                    .frame(width: size().width - 40, alignment: .leading)
                
                ScrollView {
                    HStack(spacing: 20) {
                        
                        Button {
                            isFootballShown.toggle()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: size().width / 2.4, height: 140)
                                    .cornerRadius(24)
                                    .foregroundColor(.semiPurple)
                                
                                VStack {
                                    Image("ball")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                    
                                    Text("Football")
                                        .font(.system(size: 20, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                        }
                        
                        Button {
                            isPCShown.toggle()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: size().width / 2.4, height: 140)
                                    .cornerRadius(24)
                                    .foregroundColor(.semiPurple)
                                
                                VStack {
                                    Image("display")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                    
                                    Text("PC")
                                        .font(.system(size: 20, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                        }
                    }
                    
                    HStack(spacing: 20) {
                        
                        Button {
                            isConsoleShown.toggle()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: size().width / 2.4, height: 140)
                                    .cornerRadius(24)
                                    .foregroundColor(.semiPurple)
                                
                                VStack {
                                    Image("gamepad")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                    
                                    Text("Console")
                                        .font(.system(size: 20, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                        }
                        
                        Button {
                            isCampShown.toggle()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: size().width / 2.4, height: 140)
                                    .cornerRadius(24)
                                    .foregroundColor(.semiPurple)
                                
                                VStack {
                                    Image("trophy")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                    
                                    Text("BootCamp")
                                        .font(.system(size: 20, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                            }
                            
                        }
                    }
                    .padding(.bottom, 190)
                }
                .scrollIndicators(.hidden)
                
                
                
                
            }
        }
        .onAppear {
            if let user = StorageManager.shared.persons.first {
                name = user.name
                image = user.image
            }
        }
        .overlay {
            VStack {
                Spacer()
                
                Button {
                    isReservShown.toggle()
                } label: {
                    Text("MAKE A RESERVATION")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                }
                .padding(10)
                .frame(width: size().width - 60)
                .background {
                    RoundedRectangle(cornerRadius: 18)
                        .foregroundColor(.lightPurple)
                }
            }
            .shadow(radius: 10)
            .padding(.bottom, 70)
        }
        .fullScreenCover(isPresented: $isUserShown) {
            UserDetailsView()
                .onDisappear {
                    if let user = StorageManager.shared.persons.first {
                        name = user.name
                        image = user.image
                    }
                }
        }
        .fullScreenCover(isPresented: $isReservShown) {
            ReservationView()
        }
        .fullScreenCover(isPresented: $isFootballShown) {
            FootballRoomView()
        }
        .fullScreenCover(isPresented: $isPCShown) {
            PCRoomView()
        }
        .fullScreenCover(isPresented: $isConsoleShown) {
            ConsoleRoomView()
        }
        .fullScreenCover(isPresented: $isCampShown) {
            BootcampRoomView()
        }
    }
}

#Preview {
    MainView()
}
