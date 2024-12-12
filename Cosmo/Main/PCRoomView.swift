//
//  PCRoomView.swift
//
//  Created by D K on 06.12.2024.
//

import SwiftUI

struct PCRoomView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var isReservShown = false

    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
            
            VStack {
                Image("pcRoom2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size().width, height: 220)
                    .clipped()
                    .ignoresSafeArea()
                
                ScrollView {
                    Text("PC Room")
                        .foregroundStyle(.white)
                        .font(.system(size: 32, weight: .black))
                    
                    Text("""
Welcome to the beating heart of the game club, where rows of cutting-edge PCs await to fuel your gaming adventures.

Each PC is a marvel of modern technology, equipped with the latest hardware to deliver exceptional performance. High-end graphics cards, ultra-fast processors, and generous RAM ensure that even the most demanding games run seamlessly, giving you an edge in every battle, quest, or competition.

The monitors are gateways to new realms, featuring stunningly vivid displays and crystal-clear resolutions that make every detail pop, immersing you in the action like never before.

The game library is as diverse as it is extensive, offering something for every type of gamer. Whether you're into adrenaline-pumping shooters, intricate strategy games, or immersive RPGs, there's a title waiting for you. Dive into popular favorites like Fortnite, League of Legends, or Counter-Strike 2, and join a global community of players in thrilling virtual worlds.

This is more than just a room of PCs—it's a haven for gamers, a space where technology and passion collide to create unforgettable experiences.
""")
                    .foregroundColor(.white)
                    .padding()
                    
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
            }
            
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .shadow(color: .darkPurple, radius: 10, y: 1)
                            .shadow(color: .darkPurple, radius: 10, y: 1)
                            .shadow(color: .darkPurple, radius: 10, y: 1)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
        }
        .fullScreenCover(isPresented: $isReservShown) {
            ReservationView()
        }
    }
}

#Preview {
    PCRoomView()
}
