//
//  BootcampRoomView.swift
//
//  Created by D K on 06.12.2024.
//

import SwiftUI

struct BootcampRoomView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var isReservShown = false

    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.darkPurple)
                .ignoresSafeArea()
            
            VStack {
                Image("club5")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size().width, height: 220)
                    .clipped()
                    .ignoresSafeArea()
                
                ScrollView {
                    Text("Bootcamp Room")
                        .foregroundStyle(.white)
                        .font(.system(size: 32, weight: .black))
                    
                    Text("""
Welcome to the adrenaline-fueled epicenter of the game club, where five state-of-the-art computers stand poised as arenas for aspiring cyber sports champions.

Each machine is a powerhouse of performance, armed with the latest hardware to handle the demands of intense training and high-stakes competition. Featuring lightning-fast processors, cutting-edge graphics cards, and ultra-responsive SSDs, these PCs are more than just gaming rigs—they’re precision instruments crafted for victory.

The room is thoughtfully designed for peak performance and comfort. Each station is meticulously arranged, with ergonomic chairs and adjustable desks ensuring players can maintain focus and comfort during marathon sessions. Blazing-fast internet connections guarantee ultra-low latency, delivering smooth, seamless gameplay critical for competitive success.

A rich library of cyber sport games awaits, catering to players across all genres. Whether you’re mastering tactical shooters like Counter-Strike: Global Offensive, refining strategies in MOBAs like League of Legends or Dota 2, or exploring other competitive favorites, this hub offers endless opportunities to elevate your skills.

Beyond casual play, the space is also available for rent, perfect for boot camps, training sessions, or hosting thrilling tournaments. This isn’t just a gaming room—it’s your launchpad to cyber sports greatness.
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
    BootcampRoomView()
}
