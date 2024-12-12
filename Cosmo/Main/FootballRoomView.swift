//
//  FootballRoomView.swift
//
//  Created by D K on 06.12.2024.
//

import SwiftUI

struct FootballRoomView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var isReservShown = false

    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
            
            VStack {
                Image("footballRoom1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size().width, height: 220)
                    .clipped()
                    .ignoresSafeArea()
                
                ScrollView {
                    Text("Football Room")
                        .foregroundStyle(.white)
                        .font(.system(size: 32, weight: .black))
                    
                    Text("""
Welcome to the game club's football-themed room, where the thrill of the stadium meets the cozy vibe of your living space.

Step into a space brimming with iconic football memorabilia, from signed jerseys of legendary players to framed photos immortalizing the greatest moments of the beautiful game. The walls, painted in vibrant team colors, create an electrifying atmosphere, while overhead lights evoke the glow of a floodlit stadium, adding to the immersive experience.

Comfort is key, with each seat carefully arranged for the best view of the massive flatscreen TV, continuously streaming live matches, highlights, and classic games to keep the football spirit alive.

Gaming enthusiasts will find their favorite console—be it the sleek PlayStation 5 or the powerful Xbox—ready to launch you into virtual stadiums where you can master skillful passes, net incredible goals, and lead your team to victory.

Whether you’re a devoted football fan, a gamer seeking the ultimate setup, or someone looking to relax with friends, the football-themed room at the game club is your go-to destination for sports, gaming, and good times.
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
    FootballRoomView()
}
