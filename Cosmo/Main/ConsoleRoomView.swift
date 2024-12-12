//
//  ConsoleRoomView.swift
//
//  Created by D K on 06.12.2024.
//

import SwiftUI

struct ConsoleRoomView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var isReservShown = false

    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
            
            VStack {
                Image("psRoom2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size().width, height: 220)
                    .clipped()
                    .ignoresSafeArea()
                
                ScrollView {
                    Text("Console Room")
                        .foregroundStyle(.white)
                        .font(.system(size: 32, weight: .black))
                    
                    Text("""
Welcome to the console haven of the game club, where the latest gaming consoles promise endless adventures and unforgettable moments.

As you step inside, rows of PlayStation 5 and Xbox consoles beckon, each station ready to transport you to worlds of thrilling gameplay and boundless entertainment.

The room is designed with your comfort in mind, featuring plush seating perfectly arranged around each console station to ensure an immersive and relaxing gaming experience.

The game library is vast and diverse, catering to every gaming preference. From action-packed adventures to heart-pounding shooters and captivating RPGs, there’s something to ignite every gamer’s imagination. Immerse yourself in blockbuster titles like Spider-Man: Miles Morales, Halo Infinite, or The Legend of Zelda: Breath of the Wild, and explore breathtakingly detailed worlds brimming with excitement and wonder.

This console paradise isn’t just a place to play—it’s a gateway to unforgettable journeys, where every session is an epic experience waiting to unfold.
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
    ConsoleRoomView()
}
